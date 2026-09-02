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

  security.pam.services = {
    ssdm.enableGnomeKeyring = true;
  };

  environment.systemPackages = with pkgs; [
    # xwaylandvideobridge
  ];
}
