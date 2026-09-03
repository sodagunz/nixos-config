{ inputs, ... }:
{
  flake.homeModules.noctalia = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        accessibility.ui_scale = 1.2;

        bar.default = {
          center = [
            "weather"
            "group:g3"
            "date"
          ];
          end = [
            "group:g2"
            "group:g4"
            "media"
            "group:g1"
          ];
          icon_color = "primary";
          scale = 1.5;
          start = [
            "keyboard_layout"
            "launcher"
            "control-center"
            "wallpaper"
            "screenshot"
            "workspaces"
            "group:g5"
            "group:g6"
          ];
          thickness = 48;
          widget_spacing = 12;
          capsule_group = [
            {
              id = "g1";
              members = [
                "notifications"
                "clipboard"
                "network"
                "bluetooth"
                "volume"
                "brightness"
                "battery"
                "session"
              ];
              fill = "surface_variant";
              padding = 6.0;
            }
            {
              id = "g2";
              members = [ "tray" ];
              fill = "surface_variant";
              padding = 6.0;
            }
            {
              id = "g3";
              members = [ "clock" ];
              fill = "surface_variant";
              padding = 6.0;
            }
            {
              id = "g4";
              members = [
                "GPU_Use"
                "GPU_Temp"
                "GPU_RAM"
              ];
              fill = "surface_variant";
              padding = 6.0;
            }
            {
              id = "g5";
              members = [
                "cpu"
                "temp"
                "ram"
              ];
              fill = "surface_variant";
              padding = 6.0;
            }
            {
              id = "g6";
              members = [ "Disk" ];
              fill = "surface_variant";
              padding = 6.0;
            }
          ];
        };

        control_center.width = 1200;
        location.address = "Valencia, Spain";
        nightlight.enabled = true;
        osd = {
          offset_y = 80;
          position = "bottom_center";
        };

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
          polkit_agent = true;
          telemetry_enabled = false;
          keyboard_layout.custom_labels = {
            "English (US)" = "US";
            French = "FR";
            Spanish = "ES";
          };
          panel = {
            launcher_placement = "attached";
            open_near_click_control_center = true;
            open_near_click_launcher = true;
          };
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
        widget = {
          Disk = {
            stat = "disk_used";
            type = "sysmon";
          };
          GPU_RAM = {
            stat = "gpu_vram";
            type = "sysmon";
          };
          GPU_Temp = {
            stat = "gpu_temp";
            type = "sysmon";
          };
          GPU_Use = {
            stat = "gpu_usage";
            type = "sysmon";
          };
          clock = {
            color = "primary";
            font_scale = 1.25;
            format = "{:%H:%M:%S}";
          };
          media = {
            hide_when_no_media = true;
            max_length = 140;
            show_progress = true;
            title_scroll = "always";
          };
          network = {
            show_label = false;
            vpn_status = "both";
          };
          sysmon.stat = "gpu_usage";
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
