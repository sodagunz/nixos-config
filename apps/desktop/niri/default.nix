{ ... }:
{
  flake.homeModules.niri = import ./_module;
  flake.nixosModules.niri = {
    imports = [
      ./_nixos/display-manager.nix
      ./_nixos/wayland.nix
    ];
  };
}
