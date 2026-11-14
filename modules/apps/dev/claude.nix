{ ... }:
{
  flake.homeModules.claude=
    { pkgs, ... }:
    {
      home.packages = [ pkgs.claude-code];
    };
}
