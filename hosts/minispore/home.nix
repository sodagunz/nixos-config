{ self, ... }:
{
  imports = [
    self.homeModules.bat
    self.homeModules.btop
    self.homeModules.codex
    self.homeModules.editor
    self.homeModules.fzf
    self.homeModules.fish
    self.homeModules.git
    self.homeModules.fastfetch
    self.homeModules.starship
    self.homeModules.zellij
    self.homeModules.zoxide
    self.homeModules.xdg-mimes
    ../../modules/home/workstation
  ];
}
