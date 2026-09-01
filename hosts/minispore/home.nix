{ self, ... }:
{
  imports = [
    self.homeModules.btop
    self.homeModules.codex
    self.homeModules.fzf
    self.homeModules.git
    self.homeModules.zoxide
    ../../modules/home/workstation
  ];
}
