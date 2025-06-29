{inputs, ...}: let
  ghostty = inputs.ghostty.packages.x86_64-linux.default; #FIXME use get per system
in {
  home.packages = [ghostty];

  xdg.configFile."ghostty/config".source = ./config;
}
