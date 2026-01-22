{
  config,
  pkgs,
  ...
}:
{
  programs.waybar.style = pkgs.lib.strings.fileContents ./style.css;
}
