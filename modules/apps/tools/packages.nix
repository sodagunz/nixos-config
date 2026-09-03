{ ... }:
{
  flake.homeModules.packages =
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
        mimeo # open files using MIME types

        # ---- doc
        man-pages # extra man pages
        tldr # community manpages

        # ---- TUI
        binsider # analize ELF binaries
        gtt # google translate
        lazygit # git
        ncdu # NCurses (d)isk (u)tility
        tdf # PDF renderer
        wiki-tui # Wikipedia
        ncspot # Spotify

        # ---- programming
        gcc # GNU Compiler Collection
        gdb # GNU Debugger
        gnumake # GNU Make
        just # easy make substitute
        nix-prefetch-github # prefetch nix info from github
        python3 # Python3
        valgrind # c memory analyzer
        zenity # uses GTK to retrieve user value
        python314Packages.ipython # interactive python

        # ---- system / media
        dconf-editor # configuration editor
        imv # image viewer
        libnotify # notifications daemon
        mpv # video player
        vlc # VideoLan Client
        openssl # ssl transport layer security
        sccache # cache for cargo
        pkg-config # for openssl pkg info
        pamixer # pulseaudio command line mixer
        pavucontrol # pulseaudio volume control (GUI)
        playerctl # controller for media players
        wget # HTTP Get

        # ---- info fetchers
        nitch # (ni)x fe(tch)
        onefetch # git repo fetch

        # ---- leisure
        cbonsai # terminal screensaver bonsai
        cmatrix # terminal screensaver matrix
        cowsay # cowsay
        lolcat # rainbow cat
        pipes # terminal screensaver pipes
        sl # terminal screensaver train
        toipe # speed typing with good UI
        tty-clock # terminal screensaver clock
        ttyper # speed typing good feedback on misses

        # ---- wayland tools
        wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
        xdg-utils # tools to integrate with xdg
      ];
    };
}
