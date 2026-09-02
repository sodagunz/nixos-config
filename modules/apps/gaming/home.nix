{ ... }:
{
  flake.homeModules.gaming = { pkgs, ... }: {
    home.packages = with pkgs; [
      vitetris
    ];
  };
}
