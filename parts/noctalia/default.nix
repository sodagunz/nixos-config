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
          source = "custom";
          custom_palette = "NordNight";
        };
        wallpaper = {
          enabled = true;
          default.path = "~/Pictures/wallpapers/others/nixos.png";
        };
      };

      customPalettes.NordNight.dark = {
        mPrimary = "#81a1c1";
        mOnPrimary = "#252933";
        mSecondary = "#88c0d0";
        mOnSecondary = "#252933";
        mTertiary = "#b48ead";
        mOnTertiary = "#252933";
        mError = "#bf616a";
        mOnError = "#252933";
        mSurface = "#252933";
        mOnSurface = "#c0c5cf";
        mSurfaceVariant = "#3b4252";
        mOnSurfaceVariant = "#e5e9f0";
        mOutline = "#4c566a";
        mShadow = "#252933";
        mHover = "#4c566a";
        mOnHover = "#eceff4";

        terminal = {
          background = "#252933";
          foreground = "#c0c5cf";
          cursor = "#eceff4";
          cursorText = "#252933";
          selectionBg = "#eceff4";
          selectionFg = "#4c566a";
          normal = {
            black = "#3b4252";
            red = "#bf616a";
            green = "#a3be8c";
            yellow = "#ebcb8b";
            blue = "#81a1c1";
            magenta = "#b48ead";
            cyan = "#88c0d0";
            white = "#e5e9f0";
          };
          bright = {
            black = "#4c566a";
            red = "#bf616a";
            green = "#a3be8c";
            yellow = "#ebcb8b";
            blue = "#81a1c1";
            magenta = "#b48ead";
            cyan = "#8fbcbb";
            white = "#eceff4";
          };
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
