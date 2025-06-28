_: {
  programs.micro = {
    enable = true;

    settings = {
      "colorscheme" = "gruvbox";
      "*.nix" = {
        "tabsize" = 2;
      };
      "*.ml" = {
        "tabsize" = 2;
      };
      "makefile" = {
        "tabstospaces" = false;
      };
      "tabstospaces" = true;
      "tabsize" = 4;
      "mkparents" = true;
      "colorcolumn" = 80;
    };
  };

  xdg.configFile."micro/bindings.json".source = ./bindings.json;

  xdg.configFile."micro/colorschemes/gruvbox.micro".source = ./colorschemes/gruvbox.micro;
}
