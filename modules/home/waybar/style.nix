{config, ...}: let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#${config.colorScheme.palette.base07}";
    background_0 = "#${config.colorScheme.palette.base00}";
    background_1 = "#${config.colorScheme.palette.base02}";
    border_color = "#${config.colorScheme.palette.base01}";
    red = "#${config.colorScheme.palette.base08}";
    green = "#${config.colorScheme.palette.base0C}";
    yellow = "#${config.colorScheme.palette.base0A}";
    blue = "#${config.colorScheme.palette.base0D}";
    magenta = "#${config.colorScheme.palette.base0E}";
    cyan = "#${config.colorScheme.palette.base0B}";
    orange = "#${config.colorScheme.palette.base0F}";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  programs.waybar.style = with custom; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
    }

    window#waybar {
      background: ${background_0};
      border-top: 1px solid ${border_color};
    }

    tooltip {
      background: ${background_1};
      border: 1px solid ${border_color};
    }
    tooltip label {
      margin: 5px;
      color: ${text_color};
    }

    #workspaces {
      padding-left: 15px;
    }
    #workspaces button {
      color: ${green};
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }
    #workspaces button.empty {
      color: ${text_color};
    }
    #workspaces button.active {
      color: ${cyan};
    }

    #clock {
      color: ${text_color};
    }

    #tray {
      margin-left: 10px;
      color: ${text_color};
    }
    #tray menu {
      background: ${background_1};
      border: 1px solid ${border_color};
      padding: 8px;
    }
    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #custom-notification {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 10px;
      color: ${text_color};
    }

    #pulseaudio {
      margin-left: 15px;
    }

    #custom-notification {
      margin-left: 15px;
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      color: ${text_color};
      font-weight: bold;
      margin-left: 15px;
      padding-right: 10px;
    }
  '';
}
