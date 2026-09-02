{ ... }:
{
  flake.homeModules.colors =
    {
      inputs,
      lib,
      ...
    }:
    {
      imports = [ inputs.nix-colors.homeManagerModules.default ];

      colorScheme = inputs.nix-colors.lib.schemeFromYAML "nord-night" (
        lib.readFile ./colors/nord-night.yaml
      );
    };
}
