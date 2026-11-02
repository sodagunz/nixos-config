{ self, ... }:
{
  flake.homeModules.workstation = {
    imports = with self.homeModules; [
      bat
      btop
      codex
      colors
      devenv
      discord
      editor
      element
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
      element
      flatpak
      gaming
      hardware
      niri
      noctalia
      base
    ];
  };
}
