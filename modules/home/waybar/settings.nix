{ host, config, ... }:
let
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
in
{
  programs.waybar.settings.mainBar = with custom; {
    position = "top";
    layer = "top";
    height = "2rem";
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "tray"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "cpu"
      "memory"
      (if (host == "desktop") then "disk" else "")
      "pulseaudio"
      "network"
      "battery"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = {
          today = "<span color='${text_color}'><b>{}</b></span>";
        };
      };
      format = "  {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "  {:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
      };
    };
    cpu = {
      format = "<span foreground='${green}'> </span> {usage}%";
      format-alt = "<span foreground='${green}'> </span> {avg_frequency} GHz";
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    memory = {
      format = "<span foreground='${cyan}'>󰟜 </span>{}%";
      format-alt = "<span foreground='${cyan}'>󰟜 </span>{used} GiB"; # 
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    disk = {
      # path = "/";
      format = "<span foreground='${orange}'>󰋊 </span>{percentage_used}%";
      interval = 60;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    network = {
      format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
      format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "<span foreground='${blue}'> </span> {volume}%";
      format-icons = {
        default = [ "<span foreground='${blue}'> </span>" ];
      };
      scroll-step = 2;
      on-click = "pamixer -t";
    };
    battery = {
      format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
      format-full = "<span foreground='${yellow}'> </span>{capacity}%";
      format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "custom/launcher" = {
      format = "";
      on-click = "random-wallpaper";
      on-click-right = "rofi -show drun";
      tooltip = "true";
      tooltip-format = "Random Wallpaper";
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        none = "  <span foreground='${red}'></span>";
        dnd-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        dnd-none = "  <span foreground='${red}'></span>";
        inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        inhibited-none = "  <span foreground='${red}'></span>";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
        dnd-inhibited-none = "  <span foreground='${red}'></span>";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
