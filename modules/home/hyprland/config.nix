{ ... }:
{
  imports = [
    ./looknfeel.nix
    ./rules.nix
    ./binds.nix
    ./input.nix
    ./autostart.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      "$mainMod" = "SUPER";
      monitor = [
        "HDMI-A-2,3840x2160@59.99700,0x0,1"
        # "HDMI-A-1,1920x1080@60,3840x1080,1"
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
