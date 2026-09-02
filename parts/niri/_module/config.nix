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
    spawn-at-startup "noctalia"
    spawn-at-startup "firefox"
    spawn-at-startup "ghostty"

    environment { NIXOS_OZONE_WL "1"; }

    binds {
        Mod+A hotkey-overlay-title="Open terminal" { spawn "ghostty"; }
        Mod+W hotkey-overlay-title="Open Firefox" { spawn "firefox"; }
        Mod+D hotkey-overlay-title="Open Discord" { spawn "discord"; }
        Mod+Z hotkey-overlay-title="Open Zed" { spawn "zed"; }
        Mod+E hotkey-overlay-title="Open file explorer" { spawn "nemo"; }
        Mod+Space hotkey-overlay-title="Open application launcher" { spawn-sh "noctalia msg panel-toggle launcher"; }
        Mod+S hotkey-overlay-title="Open control center" { spawn-sh "noctalia msg panel-toggle control-center"; }
        Mod+Comma hotkey-overlay-title="Open Noctalia settings" { spawn-sh "noctalia msg settings-toggle"; }
        Mod+Q { close-window; }
        Mod+F { fullscreen-window; }
        Mod+Escape { spawn-sh "noctalia msg session lock"; }
        Mod+Shift+Escape { spawn-sh "noctalia msg panel-toggle session"; }
        Mod+T { toggle-window-rule-opacity; }
        Mod+V { spawn-sh "noctalia msg panel-toggle clipboard"; }

        Print { spawn "screenshot" "--copy"; }
        Mod+Print { spawn "screenshot" "--save"; }
        Mod+Shift+Print { spawn "screenshot" "--swappy"; }

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

        Mod+Shift+H { move-column-left; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+L { move-column-right; }

        XF86AudioPlay allow-when-locked=true { spawn-sh "noctalia msg media toggle"; }
        XF86AudioNext allow-when-locked=true { spawn-sh "noctalia msg media next"; }
        XF86AudioPrev allow-when-locked=true { spawn-sh "noctalia msg media previous"; }
        XF86AudioStop allow-when-locked=true { spawn-sh "noctalia msg media stop"; }
        XF86AudioMute allow-when-locked=true { spawn-sh "noctalia msg volume-mute"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "noctalia msg volume-up 2"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "noctalia msg volume-down 2"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn-sh "noctalia msg brightness-up current 5"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn-sh "noctalia msg brightness-down current 5"; }
        Mod+F12 { spawn-sh "noctalia msg volume-up 2"; }
        Mod+F11 { spawn-sh "noctalia msg volume-down 2"; }
        Mod+F10 { spawn-sh "noctalia msg volume-mute"; }

    }

    // This gives Mod+T an alternate opacity to toggle against.
    window-rule { opacity 0.90; }

    window-rule {
        match app-id=r#"^(firefox|ghostty|com\.mitchellh\.ghostty|discord|dev\.zed\.Zed)$"#
        open-fullscreen true
    }
    window-rule {
        match app-id="dev.noctalia.Noctalia"
        open-floating true
        default-column-width { fixed 1080; }
        default-window-height { fixed 920; }
    }

    debug { honor-xdg-activation-with-invalid-serial; }
    window-rule {
        match app-id=r#"^(Viewnior|imv|mpv|audacious|udiskie|zenity|org\.gnome\.FileRoller|pavucontrol|SoundWireServer|\.sameboy-wrapped|file_progress|confirm|dialog|download|notification|error|confirmreset)$"#
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
  '';
}
