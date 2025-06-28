{
  config,
  pkgs,
  ...
}: let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#${config.colorScheme.palette.base06}";
    background_0 = "#${config.colorScheme.palette.base00}";
    background_1 = "#${config.colorScheme.palette.base02}";
    border_color = "#${config.colorScheme.palette.base01}";
    red = "#${config.colorScheme.palette.base08}";
    green = "#${config.colorScheme.palette.base0C}";
    yellow = "#${config.colorScheme.palette.base0A}";
    blue = "#${config.colorScheme.palette.base0D}";
    magenta = "#${config.colorScheme.palette.base0E}";
    cyan = "#${config.colorScheme.palette.base0B}";
    orange = "#${config.colorScheme.palette.base0F}";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  programs.waybar.style = with custom; (pkgs.lib.strings.fileContents ./style.css);
}
