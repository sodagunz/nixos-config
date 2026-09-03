{ ... }:
{
  flake.nixosModules.core =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        git
        xclip
      ];
      i18n.defaultLocale = "en_US.UTF-8";
      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [ "https://nix-gaming.cachix.org" ];
          trusted-public-keys = [
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          ];
        };
      };
      nixpkgs.config.allowUnfree = true;
      security.sudo.enable = true;
      services = {
        # Pretty much required for systemd and polkit.
        dbus.enable = true;
        dnsmasq = {
          enable = true; # Resolve local dns queries
          settings = {
            address = [
              "/homegrown/192.168.1.204"
              "/minispore/192.168.1.200"
              "/filmotheque/192.168.1.201"
            ];
            bind-interfaces = true;
            no-resolv = true;
            server = [
              "8.8.8.8"
              "8.8.4.4"
              "1.1.1.1"
            ];
          };
        };
        # Extends life of SSDs, does nothing for HHDs.
        fstrim.enable = true;
        openssh = {
          enable = true;
          settings = {
            KbdInteractiveAuthentication = false;
            PasswordAuthentication = false;
            X11Forwarding = true;
          };
        };
      };
      system.stateVersion = "24.05";
      time.timeZone = "Europe/Madrid";
    };
}
