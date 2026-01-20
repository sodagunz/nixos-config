{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Omarchy Window Rules
    # Combined from apps/*.conf and main windows.conf

    windowrule = [
      # General behavior
      "suppress_event maximize, match:class .*"

      # Default opacity
      "opacity 0.97 0.9, match:class .*"

      # Fix some dragging issues with XWayland
      "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"

      # --- Browser Rules (apps/browser.conf) ---
      # Browser types
      "tag +chromium-based-browser, match:class ((google-)?[cC]hrom(e|ium)|[bB]rave-browser|[mM]icrosoft-edge|Vivaldi-stable|helium)"
      "tag +firefox-based-browser, match:class ([fF]irefox|zen|librewolf)"

      # Force chromium-based browsers into a tile to deal with --app bug
      "tile on, match:tag chromium-based-browser"

      # Only a subtle opacity change, but not for video sites
      "opacity 1 0.97, match:tag chromium-based-browser"
      "opacity 1 0.97, match:tag firefox-based-browser"

      # Some video sites should never have opacity applied to them
      "opacity 1.0 1.0, match:initial_title ((?i)(?:[a-z0-9-]+\.)*youtube\.com_/|app\.zoom\.us_/wc/home)"

      # --- Floating Windows (apps/system.conf & general) ---
      "float on, match:tag floating-window"
      "center on, match:tag floating-window"
      "size 875 600, match:tag floating-window"

      # Tagging floating windows
      "tag +floating-window, match:class (org.omarchy.bluetui|org.omarchy.impala|org.omarchy.wiremix|org.omarchy.btop|org.omarchy.terminal|org.omarchy.bash|org.gnome.NautilusPreviewer|org.gnome.Evince|com.gabm.satty|Omarchy|About|TUI.float|imv|mpv)"
      "tag +floating-window, match:class (xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus), match:title ^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)"
      "float on, match:class org.gnome.Calculator"

      # User existing floating rules adapted
      "float on,match:class ^(Viewnior)$"
      "center on,match:class ^(Viewnior)$"
      "size 1200 800,match:class ^(Viewnior)$"
      "float on,match:class ^(imv)$"
      "center on,match:class ^(imv)$"
      "size 1200 725,match:class ^(imv)$"
      "float on,match:class ^(mpv)$"
      "center on,match:class ^(mpv)$"
      "size 1200 725,match:class ^(mpv)$"
      "tile on,match:class ^(Aseprite)$"
      "float on,match:class ^(audacious)$"
      "pin on,match:class ^(rofi)$"
      "pin on,match:class ^(waypaper)$"
      "tile on,match:class ^(neovide)$"
      "float on,match:class ^(udiskie)$"
      "float on,match:title ^(Transmission)$"
      "float on,match:title ^(Volume Control)$"
      "float on,match:title ^(Firefox — Sharing Indicator)$"
      "move 0 0,match:title ^(Firefox — Sharing Indicator)$"
      "size 700 450,match:title ^(Volume Control)$"
      "move 40 55%,match:title ^(Volume Control)$"

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

      # Fullscreen screensaver
      "fullscreen on, match:class org.omarchy.screensaver"
      "float on, match:class org.omarchy.screensaver"

      # No transparency on media windows
      "opacity 1 1, match:class ^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$"
      "opacity 1.0 override 1.0 override, match:title ^(.*imv.*)$"
      "opacity 1.0 override 1.0 override, match:title ^(.*mpv.*)$"
      "opacity 1.0 override 1.0 override, match:class (Aseprite)"
      "opacity 1.0 override 1.0 override, match:class (Unity)"
      # "opacity 1.0 override 1.0 override, match:class (firefox)" # Overridden by omarchy browser rules
      "opacity 1.0 override 1.0 override, match:class (evince)"

      # Popped window rounding
      "rounding 8, match:tag pop"

      # Prevent idle while open
      "idle_inhibit always, match:tag noidle"
      "idle_inhibit focus,match:class ^(mpv)$"
      "idle_inhibit fullscreen, match:class ^(firefox)$"

      # --- Terminals (apps/terminals.conf) ---
      "tag +terminal, match:class (Alacritty|kitty|com.mitchellh.ghostty|ghostty)"

      # --- PIP (apps/pip.conf) ---
      "tag +pip, match:title (Picture.?in.?[Pp]icture)"
      "float on, match:tag pip"
      "pin on, match:tag pip"
      "size 600 338, match:tag pip"
      "keep_aspect_ratio on, match:tag pip"
      "border_size 0, match:tag pip"
      "opacity 1 1, match:tag pip"
      "move (monitor_w-window_w-40) (monitor_h*0.04), match:tag pip"

      # Xwayland Video Bridge
      "opacity 0.0 override,match:class ^(xwaylandvideobridge)$"
      "animation none,match:class ^(xwaylandvideobridge)$"
      "no_initial_focus on,match:class ^(xwaylandvideobridge)$"
      "max_size 1 1,match:class ^(xwaylandvideobridge)$"
      "no_blur on,match:class ^(xwaylandvideobridge)$"

      # User workspace rules
      "workspace 1, match:class ^(firefox)$"
      "workspace 3, match:class ^(evince)$"
      "workspace 4, match:class ^(Gimp-2.10)$"
      "workspace 4, match:class ^(Aseprite)$"
      "workspace 5, match:class ^(Audacious)$"
      "workspace 5, match:class ^(Spotify)$"
      "workspace 8, match:class ^(com.obsproject.Studio)$"
      "workspace 10, match:class ^(discord)$"
      "workspace 10, match:class ^(WebCord)$"
    ];
  };
}
