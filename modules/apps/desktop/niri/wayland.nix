{ ... }:
{
  flake.nixosModules.niri =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        # xwaylandvideobridge
      ];
      programs.niri.enable = true;
      services.gnome.gnome-keyring.enable = true;
      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
        xdgOpenUsePortal = true;
      };
    };
}
