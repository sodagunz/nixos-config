{ self, ... }:
{
  flake.nixosModules.base = {
    imports = with self.nixosModules; [
      bootloader
      cachix
      networking
      nh
      programs
      core
      users
      virtualization
    ];
  };
}
