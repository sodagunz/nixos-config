{ ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      nswitch = "sudo nixos-rebuild switch --flake ~/nixos-config/#desktop";
    };
  };
}
