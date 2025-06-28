{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [rofi-wayland];

  xdg.configFile."rofi/theme.rasi".source = ./theme.rasi;

  xdg.configFile."rofi/config.rasi".source = ./config.rasi;
}
