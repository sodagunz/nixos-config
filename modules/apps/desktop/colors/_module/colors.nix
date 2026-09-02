{
  inputs,
  lib,
  ...
}:
{
  colorScheme = inputs.nix-colors.lib.schemeFromYAML "nord-night" (lib.readFile ./nord-night.yaml);
}
