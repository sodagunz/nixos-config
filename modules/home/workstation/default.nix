_: {
  imports = [
    ../base
    ./audacious.nix # music player
    ./browser.nix # firefox based browser
    ./cava.nix # audio visualizer
    ./colors #nix colorscheme manager
    ./gaming.nix # packages related to gaming
    ./ghostty # terminal
    ./gnome.nix # gnome apps
    ./gtk.nix # gtk theme
    ./hyprland # window manager
    ./kitty.nix # terminal
    ./micro # nano replacement
    ./nemo.nix # file manager
    ./obsidian.nix
    ./packages.nix # other packages
    ./retroarch.nix
    ./rofi # launcher
    ./scripts/scripts.nix # personal scripts
    ./swaync/swaync.nix # notification deamon
    ./swayosd # brightness / volume wiget
    ./waybar # status bar
    ./waypaper.nix # GUI wallpaper picker
    ./yazi.nix # terminal file manager
  ];
}
