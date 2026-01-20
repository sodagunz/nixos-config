_: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "nord-night";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };

  programs.vim = {
    enable = true;
  };
}

