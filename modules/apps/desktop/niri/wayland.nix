{ ... }:
{
  flake.nixosModules.niri =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      programs.niri.enable = true;
      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      services.gnome.gnome-keyring.enable = true;

      environment.systemPackages = with pkgs; [
        # xwaylandvideobridge
      ];
    };
}
