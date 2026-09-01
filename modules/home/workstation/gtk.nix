{
  pkgs,
  config,
  ...
}:
let
  # monolisa = pkgs.callPackage ../../pkgs/monolisa/monolisa.nix {};
  # monolisa-nerd = pkgs.callPackage ../../pkgs/monolisa/monolisa-nerd.nix {
  #   inherit monolisa;
  # };
in
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    twemoji-color-font
    noto-fonts-color-emoji
    fantasque-sans-mono
    maple-mono.variable
    maple-mono.truetype
    maple-mono.NF
    maple-mono.NF-CN
    montserrat
    # monolisa
    # monolisa-nerd
  ];

  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    font = {
      name = "Montserrat";
      size = 14;
    };
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}
