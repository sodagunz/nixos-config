{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Nord";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      batgrep
      # batdiff
    ];

    # themes = {
    #   tokyonight = {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "folke";
    #       repo = "tokyonight.nvim";
    #       rev = "45d22cf0e1b93476d3b6d362d720412b3d34465c";
    #       hash = "sha256-TJ/a6N6Cc1T0wdMxMopma1NtwL7rMYbZ6F0zFI1zaIA=";
    #     };
    #
    #     file = "extras/sublime/tokyonight_night.tmTheme";
    #   };
    # };
  };
}
