{ ... }:
{
  flake.homeModules.starship = { pkgs, ... }: {
    home.packages = with pkgs; [ starship ];
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableTransience = true;
      enableZshIntegration = true;
    };
    xdg.configFile."starship.toml".source = ./starship/starship.toml;
  };
}
