{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [ rofi ];

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
      bg-col: #${config.colorScheme.palette.base00};
      bg-col-light: #${config.colorScheme.palette.base02};
      border-col: #${config.colorScheme.palette.base01};
      selected-col: #${config.colorScheme.palette.base03};
      cyan: #${config.colorScheme.palette.base0C};
      fg-col: #${config.colorScheme.palette.base07};
      fg-col2: #${config.colorScheme.palette.base06};
      grey: #${config.colorScheme.palette.base05};
      highlight: @cyan;
    }
  '';

  xdg.configFile."rofi/config.rasi".source = ./config.rasi;
}
