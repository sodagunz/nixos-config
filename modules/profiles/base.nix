{ self, ... }:
{
  flake.nixosModules.base = {
    imports = with self.nixosModules; [
      agenix
      bootloader
      cachix
      comin
      networking
      nh
      programs
      core
      users
      virtualization
    ];
  };
}
