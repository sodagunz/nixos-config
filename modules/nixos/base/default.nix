# Default core modules that all systems are expected to use
_: {
  imports = [
    ./bootloader.nix
    ./network.nix
    ./nh.nix
    ./program.nix
    ./system.nix
    ./user.nix
    ./virtualization.nix
    ./cachix.nix
  ];
}
