{ pkgs, ... }:
{
  home.packages = [ pkgs.hyprlock ];

  xdg.configFile."hypr/hyprlock.conf".source = pkgs.replaceVars ./hyprlock.conf {
    wallpaper = "${../../../wallpapers/wallpaper.webp}";
  };
}
