_: {
  imports = [
    ./browser.nix # firefox based browser
    ./gaming.nix # packages related to gaming
    ./gtk.nix # gtk theme
    ./niri # window manager
    ./packages.nix # other packages
    ./scripts/scripts.nix # personal scripts
    ./swaync/swaync.nix # notification deamon
    ./waybar # status bar
  ];
}
