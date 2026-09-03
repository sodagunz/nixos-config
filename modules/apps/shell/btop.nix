{ ... }:
{
  flake.homeModules.btop =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.nvtopPackages.intel ];
      programs.btop = {
        enable = true;
        settings = {
          color_theme = "nord";
          theme_background = false;
          update_ms = 500;
        };
      };
    };
}
