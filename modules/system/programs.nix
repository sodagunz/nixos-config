{ ... }:
{
  flake.nixosModules.programs = _: {
    programs = {
      dconf.enable = true;
      firefox.enable = true;
      fish.enable = true;
      gnupg.agent = {
        enable = true;
        # enableSSHSupport = true;
        # pinentryFlavor = "";
      };
      nix-ld.enable = true;
      ssh.extraConfig = "VisualHostKey yes";
      zsh.enable = true;
      # ssh.startAgent = true;
    };
  };
}
