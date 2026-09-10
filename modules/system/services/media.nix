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
      nixpkgs.overlays = [
        inputs.copyparty.overlays.default
        (
          final: _prev:
          let
            unstable = inputs.nixpkgs-unstable.legacyPackages.${final.stdenv.hostPlatform.system};
          in
          {
            inherit (unstable) jellyfin jellyfin-ffmpeg jellyfin-web;
          }
        )
      ];
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
          forceEncodingConfig = true;
          group = "media";
          hardwareAcceleration = {
            device = "/dev/dri/renderD128";
            enable = true;
            type = "vaapi";
          };
          openFirewall = true;
          transcoding = {
            enableHardwareEncoding = true;
            hardwareDecodingCodecs = {
              h264 = true;
              hevc = true;
              hevc10bit = true;
            };
            hardwareEncodingCodecs.hevc = true;
          };
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
      # Give the media services and main user shared access to the media library.
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
      # Allow Jellyfin to access the hardware rendering devices.
      users.users.jellyfin.extraGroups = [
        "render"
        "video"
      ];
    };
}
