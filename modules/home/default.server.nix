{pkgs, ...}: {
  imports = [
    ./bat
    ./btop.nix
    ./fastfetch
    ./fish
    ./fzf.nix
    ./git.nix
    ./nvim.nix
    ./starship
    ./xdg-mimes.nix
    ./zellij
  ];

  home.packages = with pkgs; [
    entr
    eza
    fd
    file
    hexdump
    jq
    killall
    ripgrep
    unzip
    xxd
    python3
    perl
    shellcheck
  ];
}
