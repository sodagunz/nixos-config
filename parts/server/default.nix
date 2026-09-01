{ self, ... }:
{
  flake.nixosModules.base = {
    imports = with self.nixosModules; [
      bootloader
      cachix
      networking
      nh
      programs
      system
      users
      virtualization
    ];
  };

  flake.nixosModules.server = {
    imports = with self.nixosModules; [
      base
      media
      nas
      torrent
    ];
  };
}
