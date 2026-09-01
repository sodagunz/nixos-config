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
      obsidian
      packages
      retroarch
      rofi
      scripts
      starship
      swaync
      swayosd
      waybar
      waypaper
      xdg-mimes
      yazi
      zellij
      zoxide
    ];
  };
}
