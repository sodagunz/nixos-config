{ inputs, ... }:
{
  flake.homeModules.noctalia = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        shell = {
          font_family = "JetBrainsMono Nerd Font";
          telemetry_enabled = false;
        };
        theme = {
          mode = "dark";
          source = "system";
        };
        wallpaper = {
          enabled = true;
          default.path = "~/Pictures/wallpapers/others/nixos.png";
        };
      };
    };
  };

  flake.nixosModules.noctalia = {
    imports = [ inputs.noctalia.nixosModules.default ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
  };
}
