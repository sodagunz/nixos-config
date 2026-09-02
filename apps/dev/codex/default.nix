{ ... }:
{
  flake.homeModules.codex =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.codex ];
    };
}
