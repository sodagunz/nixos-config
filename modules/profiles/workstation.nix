{ self, ... }:
{
  flake.homeModules.workstation = {
    imports = with self.homeModules; [
      bat
      btop
      codex
      colors
      discord
      editor
      fastfetch
      fish
      fzf
      gaming
      git
      ghostty
      helix
      gtk
      kitty
      nemo
      niri
      noctalia
      obsidian
      packages
      retroarch
      scripts
      starship
      xdg-mimes
      yazi
      zellij
      zoxide
    ];
  };
  flake.nixosModules.workstation = {
    imports = with self.nixosModules; [
      audio
      bluetooth
      flatpak
      gaming
      hardware
      niri
      noctalia
      base
    ];
  };
}
