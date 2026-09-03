{ ... }:
{
  flake.nixosModules.nh =
    {
      pkgs,
      username,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        nix-output-monitor
        nvd
      ];
      programs.nh = {
        clean = {
          enable = true;
          extraArgs = "--keep-since 7d --keep 5";
        };
        enable = true;
        flake = "/home/${username}/nixos-config";
      };
    };
}
