{pkgs, ...}: {
  home.packages = [pkgs.swayosd];
  xdg.configFile."swayosd/style.css".source = ./style.css;
}
