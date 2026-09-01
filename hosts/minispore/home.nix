{ self, ... }:
{
  imports = [
    self.homeModules.bat
    self.homeModules.btop
    self.homeModules.codex
    self.homeModules.fzf
    self.homeModules.git
    self.homeModules.fastfetch
    self.homeModules.starship
    self.homeModules.zellij
    self.homeModules.zoxide
    ../../modules/home/workstation
  ];
}
