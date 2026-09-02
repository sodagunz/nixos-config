{ ... }:
{
  flake.homeModules.yazi =
    { ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";

        settings = {
          manager = {
            linemode = "size";
            show_hidden = true;
            show_symlink = true;
            sort_by = "natural";
            sort_dir_first = true;
            sort_reverse = false;
            sort_sensitive = false;
          };
        };

        theme.preview.syntect_theme = "${./yazi/nord.tmTheme}";
      };

      xdg.configFile."yazi/theme.toml".force = true;
    };
}
