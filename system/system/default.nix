{ ... }:
{
  flake.nixosModules.system = import ./_nixos.nix;
}
