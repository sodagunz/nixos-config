{ self, ... }:
{
  flake.nixosModules.workstation = {
    imports = with self.nixosModules; [
      audio
      bluetooth
      bootloader
      cachix
      flatpak
      gaming
      hardware
      networking
      nh
      niri
      noctalia
      programs
      system
      users
      virtualization
    ];
  };

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
}
