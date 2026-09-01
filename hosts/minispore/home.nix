{ self, ... }:
{
  imports = [
    self.homeModules.codex
    self.homeModules.fzf
    self.homeModules.zoxide
    ../../modules/home/workstation
  ];
}
