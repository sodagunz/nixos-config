{
  pkgs,
  host,
  ...
}: let
  text = "rgb(251, 241, 199)";
in {
  home.packages = [pkgs.hyprlock];

  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
}
