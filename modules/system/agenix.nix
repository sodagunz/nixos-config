{ inputs, ... }:
{
  flake.nixosModules.agenix = {
    imports = [ inputs.agenix.nixosModules.default ];
  };
}
