{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user import-environment &"
      "hash dbus-update-activation-environment 2>/dev/null &"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
      "gnome-keyring-daemon --start --components=secrets"

      "nm-applet &"
      "poweralertd &"
      "wl-clip-persist --clipboard both &"
      "wl-paste --watch cliphist store &"
      "waybar &"
      "swaync &"
      "hyprctl setcursor Bibata-Modern-Ice 24 &"
      "swww-daemon &"
      "swayosd-server &"

      "hyprlock"

      ## App auto start
      "[workspace 1 silent] firefox"
      "[workspace 2 silent] ghostty"
    ];
  };
}
