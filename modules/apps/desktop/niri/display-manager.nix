{ ... }:
{
  flake.nixosModules.niri =
    {
      inputs,
      username,
      ...
    }:
    {
      imports = [ inputs.noctalia-greeter.nixosModules.default ];

      programs.noctalia-greeter = {
        enable = true;
        settings = {
          session.default = "niri";
          user.default = username;
          keyboard = {
            layout = "us,fr";
            options = "grp:alt_caps_toggle";
            numlock = true;
          };
        };
      };

      services = {
        xserver = {
          enable = true;
          xkb.layout = "us,fr";
          displayManager.lightdm.enable = false;
        };

        displayManager = {
          defaultSession = "niri";
        };
        libinput = {
          enable = true;
          # mouse = {
          #   accelProfile = "flat";
          # };
        };
      };
    };
}
