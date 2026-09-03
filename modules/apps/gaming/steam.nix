{ ... }:
{
  flake.nixosModules.gaming =
    {
      lib,
      pkgs,
      ...
    }:
    {
      programs = {
        gamescope = {
          args = [
            "--rt"
            "--expose-wayland"
          ];
          capSysNice = true;
          enable = true;
        };
        steam = {
          dedicatedServer.openFirewall = false;
          enable = true;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
          gamescopeSession.enable = true;
          remotePlay.openFirewall = true;
        };
      };
    };
}
