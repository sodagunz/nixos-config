{pkgs, inputs, ...}:
{
  nixpkgs.overlays = [inputs.copyparty.overlays.default];
  environment.systemPackages = [pkgs.copyparty];
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";

    settings = {
      i = "0.0.0.0";
    };

    # accounts = {
    #   gunz.passwordFile = "/run/keys/copyparty/gunz_password";
    # };

    # groups = {
    #   admins = ["gunz"];
    # };

    volumes = {
      "/" = {
        path = "/srv/copyparty";
        access = {
          rwd = "*";
          # rwd = ["admins"];
        };
        flags = {
          fk = 4;
          scan = 60;
          e2d = true;
        };
      };
    };
  };

  users.users.copyparty = {
    extraGroups = [
      "keys"
    ];
  };
}
