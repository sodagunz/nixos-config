# All server-compatible nixos modules
_: {
  imports = [
    ../base
    ./media.nix
    ./nas.nix
    ./rev-proxy.nix
    ./torrent.nix
    ./tunnel.nix
  ];
}
