{ ... }:
{
  flake.nixosModules.cloudflared = import ./_nixos.nix;
}
