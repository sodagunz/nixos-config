{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us,fr";
      kb_options = "grp:alt_caps_toggle,compose:caps";

      numlock_by_default = true;
      follow_mouse = 1; # Omarchy uses 1
      float_switch_override_focus = 0;
      mouse_refocus = 0;
      sensitivity = 0;

      touchpad = {
        natural_scroll = true; # Keeping user preference
      };
    };
  };
}
