{
  pkgs,
  inputs,
  username,
  ...
}:
{
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
  environment.systemPackages = with pkgs; [
    acl
    copyparty
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  services = {

    copyparty = {
      enable = true;
      user = "copyparty";
      group = "media";

      settings = {
        i = "0.0.0.0";
      };

      volumes = {
        "/" = {
          path = "/srv";
          access = {
            rwmd = "*";
          };
          flags = {
            fk = 4;
            scan = 60;
            e2d = true;
            chmod_f = 775;
            chmod_d = 775;
            gid = 987;
          };
        };
        "/tank" = {
          path = "/tank";
          access.rwmd = "*";
          flags = {
            fk = 4;
            scan = 60;
            e2d = true;
            chmod_f = 775;
            chmod_d = 775;
          };
        };
      };
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
  };

  # Ensure copyparty and jellyfin have a common group.
  # Make my main user part of that group for convenience.
  users.groups.media.gid = 987;
  users.groups.media.members = [
    "jellyfin"
    "copyparty"
    "${username}"
  ];

  # open copyparty ports
  networking.firewall.allowedTCPPorts = [ 3923 ];
  networking.firewall.allowedUDPPorts = [ 3923 ];

  users.users.copyparty = {
    extraGroups = [
      "keys"
    ];
  };

  systemd.services.media-permissions = {
    description = "Set shared media directory permissions";
    after = [ "zfs-mount.service" ];
    before = [
      "copyparty.service"
      "jellyfin.service"
      "prowlarr.service"
      "radarr.service"
      "sonarr.service"
      "transmission.service"
    ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.acl ];
    unitConfig.RequiresMountsFor = [ "/tank" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      for directory in /srv /tank /tank/media /tank/data /tank/backups; do
        if [[ -d "$directory" ]]; then
          setfacl -m u::rwx,g:media:rwx,o::--- "$directory"
          setfacl -m d:u::rwx,d:g:media:rwx,d:o::--- "$directory"
        fi
      done
    '';
  };
}
