{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ardour # DAW

    # ---- CLI essential
    entr # perform action when file change
    eza # ls replacement
    fd # better find
    file # filetype info
    hexdump # read files as hex
    jq # json queries
    killall # exactly what you'd expect
    ripgrep # better grep
    unzip # unzip
    xxd # hexdump with more features

    # ---- CLI non-essential
    bitwise # programming calculator
    gifsicle # gif utility
    gtrash # better rm with recovery
    mimeo # open files using MIME types

    # ---- doc
    man-pages # extra man pages
    tldr # community manpages

    # ---- TUI
    binsider # analize ELF binaries
    gtt # google translate
    lazygit # git
    ncdu # NCurses (d)isk (u)tility
    ueberzugpp
    tdf # PDF renderer
    wiki-tui # Wikipedia

    # ---- programming
    gcc # GNU Compiler Collection
    gdb # GNU Debugger
    gnumake # GNU Make
    just # easy make substitute
    nix-prefetch-github # prefetch nix info from github
    nixd # nix lsp
    nixfmt # nix formatter
    python3 # Python3
    shfmt # bash formatter
    treefmt # project formatter
    valgrind # c memory analyzer
    zenity # uses GTK to retrieve user value
    python312Packages.ipython # interactive python
    taplo # toml formatter and more
    kdlfmt # kdl formatter
    yamlfmt # yaml formatter

    # ---- system / media
    caligula # disk imaging/burning
    dconf-editor # configuration editor
    ffmpeg # a/v processor
    imv # image viewer
    libnotify # notifications daemon
    mpv # video player
    openssl # ssl transport layer security
    sccache # cache for cargo
    pkg-config # for openssl pkg info
    pamixer # pulseaudio command line mixer
    pavucontrol # pulseaudio volume control (GUI)
    playerctl # controller for media players
    wget # HTTP Get
    ghc
    cabal-install
    haskell-language-server

    # ---- info fetchers
    nitch # (ni)x fe(tch)
    onefetch # git repo fetch

    # ---- leisure
    ani-cli # anime via CLI
    cbonsai # terminal screensaver bonsai
    cmatrix # terminal screensaver matrix
    cowsay # cowsay
    lolcat # rainbow cat
    pipes # terminal screensaver pipes
    sl # terminal screensaver train
    toipe # speed typing with good UI
    tty-clock # terminal screensaver clock
    ttyper # speed typing good feedback on misses
    yt-dlp-light # youtube downloader

    # ---- wayland tools
    swappy # screenshot editing tool
    wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
    xdg-utils # tools to integrate with xdg

    # ---- apps
    gimp # Photoshop without the sugar
    libreoffice # Office without the suits
    resources # GUI resources monitor
    thunderbird # Mozilla Email client
    vlc # VideoLan Client
    zed-editor

    discord
  ];
}
