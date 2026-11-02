{ ... }:
{
  flake.homeModules.devenv = { pkgs, ... }: {
    programs.devenv.enable = true;
    programs.devenv.enableFishIntegration = true;
  };
}
