{ ... }:
{
  flake.homeModules.gaming = import ./_module.nix;
  flake.nixosModules.gaming = import ./_nixos/steam.nix;
}
