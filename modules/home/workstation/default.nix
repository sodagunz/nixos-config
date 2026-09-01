_: {
  imports = [
    ./browser.nix # firefox based browser
    ./colors # nix colorscheme manager
    ./gaming.nix # packages related to gaming
    ./ghostty # terminal
    ./gtk.nix # gtk theme
    ./niri # window manager
    ./micro # nano replacement
    ./packages.nix # other packages
    ./rofi # launcher
    ./scripts/scripts.nix # personal scripts
    ./swaync/swaync.nix # notification deamon
    ./swayosd # brightness / volume wiget
    ./waybar # status bar
  ];
}
