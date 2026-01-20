{config, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      "$mainMod" = "SUPER";
      monitor = [
        "HDMI-A-2,3840x2160@59.99700,0x0,1"
        "HDMI-A-1,1920x1080@60,3840x1080,1"
      ];

      # autostart
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

        "hyprlock"

        ## App auto start
        "[workspace 1 silent] firefox"
        "[workspace 2 silent] ghostty"
      ];

      input = {
        kb_layout = "us,fr";
        kb_options = "grp:alt_caps_toggle";
        numlock_by_default = true;
        follow_mouse = 0;
        float_switch_override_focus = 0;
        mouse_refocus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        "$mainMod" = "SUPER";
        layout = "dwindle";
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(${config.colorScheme.palette.base0C}) rgb(${config.colorScheme.palette.base0D}) 45deg";
        "col.inactive_border" = "rgb(${config.colorScheme.palette.base01})";
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;

          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      dwindle = {
        # no_gaps_when_only = false;
        force_split = 0;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
        special_scale_factor = 1;
        # no_gaps_when_only = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        on_focus_under_fullscreen = true;
        middle_click_paste = false;
      };

      bind = [
        # show keybinds list
        "$mainMod ALT, H, exec, show-keybinds"

        # keybindings
        "$mainMod, A, exec, ghostty"
        "$mainMod ALT, A, exec, [float; center; size 950 650] kitty"
        "$mainMod, D, exec, [fullscreen] ghostty"
        "$mainMod SHIFT, A, exec, [float; center; size 950 650] ghostty"
        "$mainMod, W, exec, hyprctl dispatch exec '[workspace 1 silent] firefox'"
        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 0"
        "$mainMod SHIFT, F, fullscreen, 1"
        "$mainMod SHIFT, COMMA , exec, toggle_float"
        "$mainMod, COMMA , togglesplit,"
        "$mainMod, Space, exec, rofi -show drun || pkill rofi"
        "$mainMod, Escape, exec, hyprlock"
        "$mainMod SHIFT, Escape, exec, power-menu"
        "$mainMod, P, pseudo,"
        "$mainMod, T, exec, toggle_oppacity"
        "$mainMod, E, exec, nemo"
        "$mainMod SHIFT, E, exec, hyprctl dispatch exec 'ghostty yazi'"
        "$mainMod SHIFT, C ,exec, hyprpicker -a"
        "$mainMod ALT, W,exec, hyprctl dispatch exec '[float; center; size 925 615] waypaper'"
        "$mainMod, N, exec, swaync-client -t -sw"
        "CTRL SHIFT, Escape, exec, hyprctl dispatch exec '[workspace 11] resources'"
        # "$mainMod SHIFT, W, exec, vm-start"

        # screenshot TODO
        ",Print, exec, screenshot --copy"
        "$mainMod, Print, exec, screenshot --save"
        "$mainMod SHIFT, Print, exec, screenshot --swappy"

        # switch focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        # switch workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        #switch monitor
        "$mainMod SHIFT, TAB, movecurrentworkspacetomonitor, +1"
        "$mainMod SHIFT, TAB, focusmonitor, +1"
        "$mainMod, TAB, focusmonitor, +1"

        # same as above, but switch to the workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod CTRL, c, movetoworkspace, empty"

        # window control
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, l, movewindow, r"

        "$mainMod CTRL, left, resizeactive, -80 0"
        "$mainMod CTRL, right, resizeactive, 80 0"
        "$mainMod CTRL, up, resizeactive, 0 -80"
        "$mainMod CTRL, down, resizeactive, 0 80"
        "$mainMod CTRL, h, resizeactive, -80 0"
        "$mainMod CTRL, j, resizeactive, 0 80"
        "$mainMod CTRL, k, resizeactive, 0 -80"
        "$mainMod CTRL, l, resizeactive, 80 0"

        "$mainMod ALT, left, moveactive,  -80 0"
        "$mainMod ALT, right, moveactive, 80 0"
        "$mainMod ALT, up, moveactive, 0 -80"
        "$mainMod ALT, down, moveactive, 0 80"
        "$mainMod ALT, h, moveactive,  -80 0"
        "$mainMod ALT, j, moveactive, 0 80"
        "$mainMod ALT, k, moveactive, 0 -80"
        "$mainMod ALT, l, moveactive, 80 0"

        # media and volume controls
        # ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop,exec, playerctl stop"

        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # clipboard manager
        "$mainMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
      ];

      # # binds active in lockscreen
      # bindl = [
      #   # laptop brigthness
      #   ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      #   ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      #   "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
      #   "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      # ];

      # # binds that repeat when held
      # binde = [
      #   ",XF86AudioRaiseVolume,exec, pamixer -i 2"
      #   ",XF86AudioLowerVolume,exec, pamixer -d 2"
      # ];

      # mouse binding
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "float on,match:class ^(Viewnior)$"
        "center on,match:class ^(Viewnior)$"
        "size 1200 800,match:class ^(Viewnior)$"
        "float on,match:class ^(imv)$"
        "center on,match:class ^(imv)$"
        "size 1200 725,match:class ^(imv)$"
        "float on,match:class ^(mpv)$"
        "center on,match:class ^(mpv)$"
        "tile on,match:class ^(Aseprite)$"
        "size 1200 725,match:class ^(mpv)$"
        "float on,match:class ^(audacious)$"
        "pin on,match:class ^(rofi)$"
        "pin on,match:class ^(waypaper)$"
        "tile on,match:class ^(neovide)$"
        "idle_inhibit focus,match:class ^(mpv)$"
        "float on,match:class ^(udiskie)$"
        "float on,match:title ^(Transmission)$"
        "float on,match:title ^(Volume Control)$"
        "float on,match:title ^(Firefox — Sharing Indicator)$"
        "move 0 0,match:title ^(Firefox — Sharing Indicator)$"
        "size 700 450,match:title ^(Volume Control)$"
        "move 40 55%,match:title ^(Volume Control)$"
        "float on, match:title ^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, match:title ^(Picture-in-Picture)$"
        "pin on, match:title ^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, match:title ^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, match:title ^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, match:class (Aseprite)"
        "opacity 1.0 override 1.0 override, match:class (Unity)"
        "opacity 1.0 override 1.0 override, match:class (firefox)"
        "opacity 1.0 override 1.0 override, match:class (evince)"
        "workspace 1, match:class ^(firefox)$"
        "workspace 3, match:class ^(evince)$"
        "workspace 4, match:class ^(Gimp-2.10)$"
        "workspace 4, match:class ^(Aseprite)$"
        "workspace 5, match:class ^(Audacious)$"
        "workspace 5, match:class ^(Spotify)$"
        "workspace 8, match:class ^(com.obsproject.Studio)$"
        "workspace 10, match:class ^(discord)$"
        "workspace 10, match:class ^(WebCord)$"
        "idle_inhibit focus, match:class ^(mpv)$"
        "idle_inhibit fullscreen, match:class ^(firefox)$"
        "float on,match:class ^(waypaper)$"
        "float on,match:class ^(zenity)$"
        "center on,match:class ^(zenity)$"
        "size 850 500,match:class ^(zenity)$"
        "float on,match:class ^(org.gnome.FileRoller)$"
        "center on,match:class ^(org.gnome.FileRoller)$"
        "size 850 500,match:class ^(org.gnome.FileRoller)$"
        "size 850 500,match:title ^(File Upload)$"
        "float on,match:class ^(pavucontrol)$"
        "float on,match:class ^(SoundWireServer)$"
        "float on,match:class ^(.sameboy-wrapped)$"
        "float on,match:class ^(file_progress)$"
        "float on,match:class ^(confirm)$"
        "float on,match:class ^(dialog)$"
        "float on,match:class ^(download)$"
        "float on,match:class ^(notification)$"
        "float on,match:class ^(error)$"
        "float on,match:class ^(confirmreset)$"
        "float on,match:title ^(Open File)$"
        "float on,match:title ^(File Upload)$"
        "float on,match:title ^(branchdialog)$"
        "float on,match:title ^(Confirm to replace files)$"
        "float on,match:title ^(File Operation Progress)$"

        "opacity 0.0 override,match:class ^(xwaylandvideobridge)$"
        "animation none,match:class ^(xwaylandvideobridge)$"
        "no_initial_focus on,match:class ^(xwaylandvideobridge)$"
        "max_size 1 1,match:class ^(xwaylandvideobridge)$"
        "no_blur on,match:class ^(xwaylandvideobridge)$"

        # No gaps when only
        "border_size 0, float on ing:0, match:workspace w[t1]"
        "rounding 0, float on ing:0, match:workspace w[t1]"
        "border_size 0, float on ing:0, match:workspace w[tg1]"
        "rounding 0, float on ing:0, match:workspace w[tg1]"
        "border_size 0, float on ing:0, match:workspace f[1]"
        "rounding 0, float on ing:0, match:workspace f[1]"

        # Remove context menu transparency in chromium based apps
        "opaque on,match:class ^()$,match:title ^()$"
        "no_shadow on,match:class ^()$,match:title ^()$"
        "no_blur on,match:class ^()$,match:title ^()$"
      ];

      workspace = [
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };

    extraConfig = "
      monitor=,preferred,auto,auto

      xwayland {
        force_zero_scaling = true
      }
    ";
  };
}
