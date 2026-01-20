{ pkgs, ... }:
{
  home.packages = with pkgs; [ ghostty ];

  xdg.configFile."ghostty/config".source = ./config;
  xdg.configFile."ghostty/themes/nord-night".source = ./themes/nord-night;
}
