{ config, ... }:
{
  programs.zellij = {
    enable = true;
  };
  home.file."${config.xdg.configHome}/zellij/config.kdl".source = ./config.kdl;
  home.file."${config.xdg.configHome}/zellij/layouts/default.kdl".source = ./layouts/default.kdl;
}
