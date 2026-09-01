{ self, ... }:
{
  imports = [
    self.homeModules.codex
    ../../modules/home/workstation
  ];
}
