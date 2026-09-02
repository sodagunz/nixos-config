{ inputs, ... }:
{
  flake.homeModules.noctalia = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        accessibility.ui_scale = 1.2;

        bar.default = {
          end = [
            "media"
            "tray"
            "notifications"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "control-center"
            "session"
            "screenshot"
          ];
          icon_color = "primary";
          scale = 1.5;
          thickness = 48;
          widget_spacing = 12;
        };

        control_center.width = 1000;

        lockscreen_widgets = {
          enabled = false;
          schema_version = 2;
          widget_order = [ "lockscreen-login-box@HDMI-A-2" ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget."lockscreen-login-box@HDMI-A-2" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 1920.0;
            cy = 1978.0;
            output = "HDMI-A-2";
            placement_height = 2160.0;
            placement_width = 3840.0;
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
        };

        shell = {
          font_family = "Montserrat";
          telemetry_enabled = false;
          panel.launcher_position = "top_center";
        };
        theme = {
          mode = "dark";
          source = "custom";
          custom_palette = "NordNight";
        };
        wallpaper = {
          directory = "/home/gunz/Pictures/wallpapers/others";
          enabled = true;
          default.path = "/home/gunz/Pictures/wallpapers/others/nord2.webp";
          monitors."HDMI-A-2".path = "/home/gunz/Pictures/wallpapers/others/nord2.webp";
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
