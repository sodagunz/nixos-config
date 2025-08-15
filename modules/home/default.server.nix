{pkgs, ...}: {
  imports = [
    ./bat
    ./btop.nix
    ./fastfetch
    ./fish
    ./fzf.nix
    ./git.nix
    ./nvim.nix
    ./xdg-mimies.nix
  ];

  home.packages = with pkgs; [
    entr
    aza
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
