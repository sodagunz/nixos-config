# Default core modules that all systems are expected to use
{ self, ... }:
{
  imports = [
    self.nixosModules.bootloader
    self.nixosModules.cachix
    self.nixosModules.networking
    self.nixosModules.nh
    self.nixosModules.programs
    self.nixosModules.system
    self.nixosModules.users
    self.nixosModules.virtualization
  ];
}
