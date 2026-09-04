{ ... }:
{
  flake.nixosModules.cloudStorage =
    {
      config,
      pkgs,
      ...
    }:
    let
      integrationImmich = pkgs.fetchNextcloudApp {
        appName = "integration_immich";
        appVersion = "1.4.0";
        hash = "sha256-PKL0FtM2oVWqlo1lAm3G3pC8Tkfzm/W4ySWAa4HG9R4=";
        license = "agpl3Plus";
        url = "https://github.com/xXRoxXeRXx/integration_immich/releases/download/v1.4.0/integration_immich.tar.gz";
      };
    in
    {
      networking.firewall.allowedTCPPorts = [
        2283
        8888
        9980
      ];
      services.collabora-online = {
        aliasGroups = [
          {
            host = "http://192.168.1.201:8888";
          }
        ];
        enable = true;
        settings = {
          net.listen = "any";
          server_name = "192.168.1.201:9980";
          ssl = {
            enable = false;
            termination = false;
          };
          storage.wopi."@allow" = true;
        };
      };
      services.immich = {
        enable = true;
        host = "0.0.0.0";
        mediaLocation = "/tank/media/pictures";
        settings.server.externalDomain = "http://192.168.1.201:2283";
      };
      services.nextcloud = {
        config = {
          adminpassFile = config.age.secrets.nextcloud-admin-password.path;
          adminuser = "gunz";
          dbtype = "pgsql";
        };
        database.createLocally = true;
        datadir = "/var/lib/nextcloud";
        enable = true;
        extraApps = with config.services.nextcloud.package.packages.apps; {
          inherit collectives richdocuments;
          integration_immich = integrationImmich;
        };
        extraAppsEnable = true;
        hostName = "192.168.1.201";
        https = false;
        maxUploadSize = "16G";
        package = pkgs.nextcloud32;
        settings.allow_local_remote_servers = true;
      };
      services.nginx.virtualHosts."192.168.1.201".listen = [
        {
          addr = "0.0.0.0";
          port = 8888;
        }
      ];
      # Nextcloud keeps its own state on the SSD and sees the pool through an
      # external-storage mount. Immich's managed uploads remain on ZFS.
      systemd.services.cloud-storage-permissions = {
        after = [
          "media-permissions.service"
          "zfs-mount.service"
        ];
        before = [
          "immich-server.service"
          "nextcloud-tank-mount.service"
        ];
        description = "Create and secure cloud-storage data directories";
        path = [
          pkgs.acl
          pkgs.coreutils
        ];
        script = ''
          install -d -m 0700 -o immich -g immich /tank/media/pictures

          # Replace the traversal-only ACLs from the previous Nextcloud data
          # directory with access suitable for the all-pool external mount.
          for directory in /tank /tank/media /tank/data /tank/backups; do
            if [[ -d "$directory" ]]; then
              setfacl -m u:nextcloud:rwx,d:u:nextcloud:rwx "$directory"
            fi
          done

          # Immich keeps this tree private by default, so grant Nextcloud the
          # explicit access its all-pool external mount needs.
          setfacl -R -m u:nextcloud:rwX /tank/media/pictures
          setfacl -m d:u:nextcloud:rwX /tank/media/pictures
        '';
        serviceConfig = {
          RemainAfterExit = true;
          Type = "oneshot";
        };
        unitConfig.RequiresMountsFor = [
          "/tank/media"
        ];
        wantedBy = [ "multi-user.target" ];
      };
      systemd.services.immich-server = {
        after = [ "cloud-storage-permissions.service" ];
        requires = [ "cloud-storage-permissions.service" ];
        unitConfig.RequiresMountsFor = [ "/tank/media/pictures" ];
      };
      systemd.services.nextcloud-immich-integration = {
        after = [ "nextcloud-setup.service" ];
        description = "Configure the Nextcloud Immich integration";
        path = [ config.services.nextcloud.occ ];
        requires = [ "nextcloud-setup.service" ];
        script = ''
          nextcloud-occ config:user:set gunz integration_immich server_url \
            --value=http://127.0.0.1:2283
        '';
        serviceConfig = {
          RemainAfterExit = true;
          Type = "oneshot";
        };
        wantedBy = [ "multi-user.target" ];
      };
      systemd.services.nextcloud-office = {
        after = [
          "coolwsd.service"
          "nextcloud-setup.service"
        ];
        description = "Configure Nextcloud Office to use the local Collabora server";
        path = [ config.services.nextcloud.occ ];
        requires = [
          "coolwsd.service"
          "nextcloud-setup.service"
        ];
        script = ''
          nextcloud-occ config:app:set richdocuments wopi_url \
            --value=http://192.168.1.201:9980
        '';
        serviceConfig = {
          RemainAfterExit = true;
          Type = "oneshot";
        };
        wantedBy = [ "multi-user.target" ];
      };
      # The External Storage app and its mount are application state, but this
      # service makes that state reproducible from the NixOS configuration.
      systemd.services.nextcloud-tank-mount = {
        after = [
          "cloud-storage-permissions.service"
          "nextcloud-setup.service"
        ];
        description = "Configure Nextcloud's /tank external-storage mount";
        path = [
          config.services.nextcloud.occ
          pkgs.gnugrep
        ];
        requires = [
          "cloud-storage-permissions.service"
          "nextcloud-setup.service"
        ];
        script = ''
          nextcloud-occ app:enable files_external

          if ! nextcloud-occ files_external:list | grep -Fq '| /tank '; then
            nextcloud-occ files_external:create /tank local null::null -c datadir=/tank
          fi
        '';
        serviceConfig = {
          RemainAfterExit = true;
          Type = "oneshot";
        };
        unitConfig.RequiresMountsFor = [ "/tank" ];
        wantedBy = [ "multi-user.target" ];
      };
      systemd.services.nextcloud-tank-scan = {
        after = [ "nextcloud-tank-mount.service" ];
        description = "Scan Nextcloud's /tank external-storage mount";
        path = [ config.services.nextcloud.occ ];
        requires = [ "nextcloud-tank-mount.service" ];
        script = ''
          nextcloud-occ files:scan gunz --quiet
        '';
        serviceConfig.Type = "oneshot";
        unitConfig.RequiresMountsFor = [ "/tank" ];
      };
      systemd.timers.nextcloud-tank-scan = {
        timerConfig = {
          OnCalendar = "hourly";
          Persistent = true;
          Unit = "nextcloud-tank-scan.service";
        };
        wantedBy = [ "timers.target" ];
      };
    };
}
