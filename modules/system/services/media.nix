{ ... }:
{
  flake.nixosModules.media =
    {
      inputs,
      pkgs,
      username,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        acl
        copyparty
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
      ];
      # open copyparty ports
      networking.firewall.allowedTCPPorts = [ 3923 ];
      networking.firewall.allowedUDPPorts = [ 3923 ];
      nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
      services = {

        copyparty = {
          enable = true;
          group = "media";
          settings = {
            i = "0.0.0.0";
          };
          user = "copyparty";
          volumes = {
            "/" = {
              access = {
                rwmd = "*";
              };
              flags = {
                chmod_d = 775;
                chmod_f = 775;
                e2d = true;
                fk = 4;
                gid = 987;
                scan = 60;
              };
              path = "/srv";
            };
            "/tank" = {
              access.rwmd = "*";
              flags = {
                chmod_d = 775;
                chmod_f = 775;
                e2d = true;
                fk = 4;
                scan = 60;
              };
              path = "/tank";
            };
          };
        };

        jellyfin = {
          enable = true;
          group = "media";
          openFirewall = true;
        };
      };
      systemd.services.media-permissions = {
        after = [ "zfs-mount.service" ];
        before = [
          "copyparty.service"
          "jellyfin.service"
          "prowlarr.service"
          "radarr.service"
          "sonarr.service"
          "transmission.service"
        ];
        description = "Set shared media directory permissions";
        path = [ pkgs.acl ];
        script = ''
          for directory in /srv /tank /tank/media /tank/data /tank/backups; do
            if [[ -d "$directory" ]]; then
              setfacl -m u::rwx,g:media:rwx,o::--- "$directory"
              setfacl -m d:u::rwx,d:g:media:rwx,d:o::--- "$directory"
            fi
          done
        '';
        serviceConfig = {
          RemainAfterExit = true;
          Type = "oneshot";
        };
        unitConfig.RequiresMountsFor = [ "/tank" ];
        wantedBy = [ "multi-user.target" ];
      };
      # Ensure copyparty and jellyfin have a common group.
      # Make my main user part of that group for convenience.
      users.groups.media.gid = 987;
      users.groups.media.members = [
        "immich"
        "jellyfin"
        "nextcloud"
        "copyparty"
        "${username}"
      ];
      users.users.copyparty = {
        extraGroups = [
          "keys"
        ];
      };
    };
}
