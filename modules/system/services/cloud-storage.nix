{ ... }:
{
  flake.nixosModules.cloudStorage =
    {
      config,
      pkgs,
      ...
    }:
    {
      networking.firewall.allowedTCPPorts = [
        2283
        8888
      ];
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
        hostName = "192.168.1.201";
        https = false;
        maxUploadSize = "16G";
        package = pkgs.nextcloud32;
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
