{ inputs, username, host, ... }: {
  imports = [
    ./audacious.nix # music player
    ./bat.nix # better cat command
    ./browser.nix # firefox based browser
    ./btop.nix # resouces monitor 
    ./cava.nix # audio visualizer
    ./fastfetch.nix # fetch tool
    ./fzf.nix # fuzzy finder
    ./gaming.nix # packages related to gaming
    ./ghostty.nix # terminal
    ./git.nix # version control
    ./gnome.nix # gnome apps
    ./gtk.nix # gtk theme
    ./hyprland # window manager
    ./kitty.nix # terminal
    ./micro.nix # nano replacement
    ./nemo.nix # file manager
    ./nvim.nix # neovim editor
    ./obsidian.nix
    ./packages.nix # other packages
    ./retroarch.nix
    ./rofi.nix # launcher
    ./scripts/scripts.nix # personal scripts
    ./swayosd.nix # brightness / volume wiget
    ./swaync/swaync.nix # notification deamon
    ./waybar # status bar
    ./waypaper.nix # GUI wallpaper picker
    ./xdg-mimes.nix # xdg config
    ./yazi.nix # terminal file manager
    ./fish #shell
    ./starship #shell bar
    ./colors #nix colorscheme manager
  ];
}
