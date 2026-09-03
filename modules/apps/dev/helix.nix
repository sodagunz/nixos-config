{ ... }:
{
  flake.homeModules.helix =
    { ... }:
    {
      programs.helix = {
        enable = true;
        settings = {
          editor = {
            line-number = "relative";
            lsp.display-messages = true;
          };
          theme = "nord-night";
        };
      };
    };
}
