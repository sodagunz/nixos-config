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
            rwd = "*";
            # rwd = ["admins"];
          };
          flags = {
            fk = 4;
            scan = 60;
            e2d = true;
            chmod_f = "775";
            chmod_d = "775";
            gid = 987;
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
  users.groups.media.members = [
    "jellyfin"
    "copyparty"
    "${username}"
  ];

  users.users.copyparty = {
    extraGroups = [
      "keys"
    ];
  };

  # fileSystems."/srv".options = ["defaults" "acl"];

  system.activationScripts.setSharedAcls = with pkgs; ''
    ${acl}/bin/setfacl -R -m d:u::rwx,d:g:media:rwx,d:o::--- /srv
    ${acl}/bin/setfacl -R -m u::rwx,g:media:rwx,o::--- /srv
  '';
}
