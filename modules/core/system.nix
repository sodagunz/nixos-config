{
  pkgs,
  inputs,
  ...
}: {
  security.sudo.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };
  nixpkgs = {
    overlays = [inputs.nur.overlays.default];
  };

  environment.systemPackages = with pkgs; [
    git
    xclip
  ];

  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";

  services = {
    # Extends life of SSDs, does nothing for HHDs.
    fstrim.enable = true;
    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };
    dbus.enable = true; # Pretty much required for systemd and polkit.

    # Prevent shutdown on tapping the power key:
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
  };
}
