{ self, ... }:
{
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
