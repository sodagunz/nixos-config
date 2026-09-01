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
      audacious
      bat
      btop
      browser
      cava
      codex
      colors
      editor
      fastfetch
      fish
      fzf
      gaming
      git
      ghostty
      gnome
      gtk
      kitty
      micro
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
