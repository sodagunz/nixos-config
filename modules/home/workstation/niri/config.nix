{config, ...}: {
  xdg.configFile."niri/config.kdl".text = ''
    output "HDMI-A-2" {
        mode "3840x2160@59.997"
        position x=0 y=0
        scale 1
    }
    output "HDMI-A-1" {
        mode "1920x1080@60"
        position x=3840 y=1080
        scale 1
    }

    input {
        keyboard {
            xkb {
                layout "us,fr"
                options "grp:alt_caps_toggle"
            }
            numlock
        }
        touchpad { natural-scroll; }
        focus-follows-mouse max-scroll-amount="0%"
    }

    cursor {
        xcursor-theme "Bibata-Modern-Ice"
        xcursor-size 24
    }

    layout {
        gaps 5
        center-focused-column "never"
        default-column-width { proportion 0.5; }
        focus-ring { off; }
        border {
            width 2
            active-color "#${config.colorScheme.palette.base0C}"
            inactive-color "#${config.colorScheme.palette.base01}"
        }
        shadow {
            on
            softness 20
            spread 2
            offset x=0 y=2
            color "#00000055"
        }
    }

    prefer-no-csd
    screenshot-path "~/Pictures/Screenshots/Screenshot_%Y_%m_%d_at_%Hh%Mm%Ss.png"

    spawn-at-startup "sh" "-c" "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"
    spawn-at-startup "gnome-keyring-daemon" "--start" "--components=secrets"
    spawn-at-startup "nm-applet"
    spawn-at-startup "poweralertd"
    spawn-at-startup "wl-clip-persist" "--clipboard" "both"
    spawn-at-startup "wl-paste" "--watch" "cliphist" "store"
    spawn-at-startup "waybar"
    spawn-at-startup "swaync"
    spawn-at-startup "swayosd-server"
    spawn-at-startup "sh" "-c" "swaybg -i ~/Pictures/wallpapers/others/nixos.png -m fill"
    spawn-at-startup "firefox"
    spawn-at-startup "ghostty"

    environment { NIXOS_OZONE_WL "1"; }

    binds {
        Mod+Alt+H hotkey-overlay-title="Show keybindings" { spawn "show-keybinds"; }
        Mod+A hotkey-overlay-title="Open terminal" { spawn "ghostty"; }
        Mod+Alt+A hotkey-overlay-title="Open floating Kitty" { spawn "kitty"; }
        Mod+D hotkey-overlay-title="Open terminal and fullscreen it" { spawn-sh "ghostty & sleep 0.2; niri msg action fullscreen-window"; }
        Mod+Shift+A hotkey-overlay-title="Open floating terminal" { spawn "ghostty"; }
        Mod+W hotkey-overlay-title="Open Firefox" { spawn "firefox"; }
        Mod+Q { close-window; }
        Mod+F { fullscreen-window; }
        Mod+Shift+F { maximize-column; }
        Mod+Shift+Comma { toggle-window-floating; }
        Mod+Comma { consume-or-expel-window-left; }
        Mod+Space { spawn-sh "rofi -show drun || pkill rofi"; }
        Mod+Escape { spawn "swaylock" "-f" "-c" "000000"; }
        Mod+Shift+Escape { spawn "power-menu"; }
        Mod+P { toggle-column-tabbed-display; }
        Mod+T { toggle-window-rule-opacity; }
        Mod+E { spawn "nemo"; }
        Mod+Shift+E { spawn "ghostty" "yazi"; }
        Mod+Shift+C { spawn "niri" "msg" "pick-color"; }
        Mod+Alt+W { spawn "waypaper"; }
        Mod+N { spawn "swaync-client" "-t" "-sw"; }
        Ctrl+Shift+Escape { spawn "resources"; }

        Print { spawn "screenshot" "--copy"; }
        Mod+Print { spawn "screenshot" "--save"; }
        Mod+Shift+Print { spawn "screenshot" "--swappy"; }

        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up { focus-window-up; }
        Mod+Down { focus-window-down; }
        Mod+H { focus-column-left; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        Mod+L { focus-column-right; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Tab { focus-monitor-next; }
        Mod+Shift+Tab { move-workspace-to-monitor-next; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+0 { move-column-to-workspace 10; }

        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+H { move-column-left; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+L { move-column-right; }

        Mod+Ctrl+Left { set-column-width "-80"; }
        Mod+Ctrl+Right { set-column-width "+80"; }
        Mod+Ctrl+Up { set-window-height "-80"; }
        Mod+Ctrl+Down { set-window-height "+80"; }
        Mod+Ctrl+H { set-column-width "-80"; }
        Mod+Ctrl+J { set-window-height "+80"; }
        Mod+Ctrl+K { set-window-height "-80"; }
        Mod+Ctrl+L { set-column-width "+80"; }

        XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioNext allow-when-locked=true { spawn "playerctl" "next"; }
        XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }
        XF86AudioStop allow-when-locked=true { spawn "playerctl" "stop"; }
        XF86AudioMute allow-when-locked=true { spawn "swayosd-client" "--output-volume" "mute-toggle"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn "swayosd-client" "--output-volume" "+2" "--max-volume=100"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "swayosd-client" "--output-volume" "-2"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "swayosd-client" "--brightness" "raise" "5%+"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "swayosd-client" "--brightness" "lower" "5%-"; }
        Mod+F12 { spawn "swayosd-client" "--output-volume" "+2" "--max-volume=100"; }
        Mod+F11 { spawn "swayosd-client" "--output-volume" "-2"; }
        Mod+F10 { spawn "swayosd-client" "--output-volume" "mute-toggle"; }

        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
        Mod+V { spawn-sh "cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"; }
    }

    window-rule {
        match app-id=r#"^(Viewnior|imv|mpv|audacious|udiskie|waypaper|zenity|org\.gnome\.FileRoller|pavucontrol|SoundWireServer|\.sameboy-wrapped|file_progress|confirm|dialog|download|notification|error|confirmreset)$"#
        open-floating true
    }
    window-rule {
        match title=r#"^(Transmission|Volume Control|Firefox — Sharing Indicator|Picture-in-Picture|Open File|File Upload|branchdialog|Confirm to replace files|File Operation Progress)$"#
        open-floating true
    }
    window-rule {
        match app-id="firefox" at-startup=true
        open-on-workspace "1"
    }
    window-rule {
        match app-id=r#"^(ghostty|com\.mitchellh\.ghostty)$"# at-startup=true
        open-on-workspace "2"
    }
    window-rule { match app-id="evince"; open-on-workspace "3"; }
    window-rule { match app-id=r#"^(Gimp-2.10|Aseprite)$"#; open-on-workspace "4"; }
    window-rule { match app-id=r#"^(Audacious|Spotify)$"#; open-on-workspace "5"; }
    window-rule { match app-id="com.obsproject.Studio"; open-on-workspace "8"; }
    window-rule { match app-id=r#"^(discord|WebCord)$"#; open-on-workspace "10"; }
  '';
}
