{ ... }:
{
  flake.homeModules.ghostty =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.ghostty ];

      xdg.configFile."ghostty/config".source = ./ghostty/config;
      xdg.configFile."ghostty/themes/nord-night".source = ./ghostty/themes/nord-night;
    };
}
