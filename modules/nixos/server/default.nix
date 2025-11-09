# All server-compatible nixos modules
_: {
  imports = [
    ../base
    ./media.nix
    ./nas.nix
    ./torrent.nix
  ];
}
