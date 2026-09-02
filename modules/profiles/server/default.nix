{ self, ... }:
{
  flake.homeModules.server = import ./_home.nix;

  flake.nixosModules.server = {
    imports = with self.nixosModules; [
      agenix
      base
      cloudflared
      media
      nas
      torrent
    ];
  };
}
