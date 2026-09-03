{ ... }:
{
  flake.homeModules.zellij = { config, ... }: {
    home.file."${config.xdg.configHome}/zellij/config.kdl".source = ./zellij/config.kdl;
    home.file."${config.xdg.configHome}/zellij/layouts/default.kdl".source =
      ./zellij/layouts/default.kdl;
    programs.zellij = {
      enable = true;
    };
  };
}
