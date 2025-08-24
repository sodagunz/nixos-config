{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  security.pam.services = {
    ssdm.enableGnomeKeyring = true;
    hyprlock.enableGnomeKeyring = true;
  };

  environment.systemPackages = with pkgs; [
    # xwaylandvideobridge
  ];
}
