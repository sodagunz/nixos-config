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
          keyboard = {
            layout = "us,fr";
            numlock = true;
            options = "grp:alt_caps_toggle";
          };
          session.default = "niri";
          user.default = username;
        };
      };

      services = {
        displayManager = {
          defaultSession = "niri";
        };
        libinput = {
          enable = true;
          # mouse = {
          #   accelProfile = "flat";
          # };
        };
        xserver = {
          displayManager.lightdm.enable = false;
          enable = true;
          xkb.layout = "us,fr";
        };
      };
    };
}
