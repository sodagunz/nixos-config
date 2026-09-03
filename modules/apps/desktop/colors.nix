{ ... }:
{
  flake.homeModules.colors =
    {
      inputs,
      lib,
      ...
    }:
    {
      colorScheme = inputs.nix-colors.lib.schemeFromYAML "nord-night" (
        lib.readFile ./colors/nord-night.yaml
      );
      imports = [ inputs.nix-colors.homeManagerModules.default ];
    };
}
