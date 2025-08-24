_: {
  programs = {
    dconf.enable = true;
    zsh.enable = true;
    fish.enable = true;
    firefox.enable = true;
    gnupg.agent = {
      enable = true;
      # enableSSHSupport = true;
      # pinentryFlavor = "";
    };
    nix-ld.enable = true;
    ssh.startAgent = true;
  };

  # services.gnome.gnome-keyring.enable = true;
}
