{inputs, ...}: {
  imports = [
    ./colors.nix
    inputs.nix-colors.homeManagerModules.default
  ];
}
