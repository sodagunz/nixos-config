{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # --- Omarchy Tiling Bindings ---
      "$mod, Q, killactive,"

      # Control tiling
      "$mod, Slash, togglesplit," # dwindle
      "$mod, P, pseudo," # dwindle
      "$mod SHIFT, V, togglefloating,"
      "SHIFT, F11, fullscreen, 0"
      "ALT, F11, fullscreen, 1"
      "$mod, F, fullscreen, 0" # User alternate
      "$mod SHIFT, F, fullscreen, 1" # User alternate

      # Move focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, h, movefocus, l"
      "$mod, j, movefocus, d"
      "$mod, k, movefocus, u"
      "$mod, l, movefocus, r"

      # Switch workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # Move active window to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # TAB between workspaces
      "$mod, TAB, workspace, e+1"
      "$mod SHIFT, TAB, workspace, e-1"

      # Swap active window
      "$mod SHIFT, left, swapwindow, l"
      "$mod SHIFT, right, swapwindow, r"
      "$mod SHIFT, up, swapwindow, u"
      "$mod SHIFT, down, swapwindow, d"

      # Cycle windows
      "ALT, TAB, cyclenext,"
      "ALT, TAB, bringactivetotop,"
      "ALT SHIFT, TAB, cyclenext, prev"
      "ALT SHIFT, TAB, bringactivetotop,"

      # Resize active window (using user's resizing values for better control)
      "$mod CTRL, left, resizeactive, -80 0"
      "$mod CTRL, right, resizeactive, 80 0"
      "$mod CTRL, up, resizeactive, 0 -80"
      "$mod CTRL, down, resizeactive, 0 80"
      "$mod CTRL, h, resizeactive, -80 0"
      "$mod CTRL, j, resizeactive, 0 80"
      "$mod CTRL, k, resizeactive, 0 -80"
      "$mod CTRL, l, resizeactive, 80 0"

      # --- App Launches (Adapted to User Tools) ---
      "$mod, SPACE, exec, rofi -show drun || pkill rofi"
      "$mod, A, exec, ghostty"
      "$mod, W, exec, firefox"
      "$mod SHIFT, Delete, exec, resources"
      "$mod ALT, A, exec, [float; center; size 950 650] kitty"
      "$mod, E, exec, nemo"
      "$mod SHIFT, E, exec, hyprctl dispatch exec 'ghostty yazi'"
      "$mod, Escape, exec, hyprlock"
      "$mod SHIFT, Escape, exec, wlogout || power-menu"
      "$mod SHIFT, C ,exec, hyprpicker -a"
      "$mod ALT, W,exec, hyprctl dispatch exec '[float; center; size 925 615] waypaper'"
      "$mod, N, exec, swaync-client -t -sw"

      # Screenshots
      ",Print, exec, screenshot --copy"
      "$mod, Print, exec, screenshot --save"
      "$mod SHIFT, Print, exec, screenshot --swappy"

      # Clipboard
      "$mod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"

      # Scroll through workspaces
      "$mod, mouse_down, workspace, e-1"
      "$mod, mouse_up, workspace, e+1"
    ];

    # Mouse bindings
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    # --- Media & OSD Bindings (Adapted to SwayOSD) ---
    # Omarchy uses swayosd-client --monitor focused... we can use swayosd-client directly as user requested adaptation

    bindl = [
      ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioStop, exec, playerctl stop"

      "CAPS,Caps_Lock,exec,swayosd-client --caps-lock"
      ", Scroll_Lock,exec,swayosd-client --scroll-lock"
      ", Num_Lock,exec,swayosd-client --num-lock"

      "$mod, XF86MonBrightnessUp, exec, brightnessctl set 100%"
      "$mod, XF86MonBrightnessDown, exec, brightnessctl set 0%"
    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise 5%+"
      ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower 5%-"

      "$mod, f12, exec, swayosd-client --output-volume +2 --max-volume=100"
      "$mod, f11, exec, swayosd-client --output-volume -2"
      "$mod, f10, exec, swayosd-client --output-volume mute-toggle"
    ];
  };
}
