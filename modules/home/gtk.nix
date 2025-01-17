{
  pkgs,
  config,
  ...
}: let
  monolisa = pkgs.callPackage ../../pkgs/monolisa/monolisa.nix {};
  monolisa-nerd = pkgs.callPackage ../../pkgs/monolisa/monolisa-nerd.nix {
    inherit monolisa;
  };
in {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    twemoji-color-font
    noto-fonts-emoji
    fantasque-sans-mono
    maple-mono
    # monolisa
    # monolisa-nerd
  ];

  gtk = {
    enable = true;
    font = {
      name = "Maple Mono";
      size = 12;
    };
    theme = {
      name = "Tokyonight-Purple-Dark-Compact";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = ["dark"];
        themeVariants = ["purple"];
        sizeVariants = ["compact"];
        tweakVariants = ["black"];
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "black";};
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}
