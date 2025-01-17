_: {
  security = {
    rtkit.enable = true;
    sudo.enable = true;
    pam.services = {
      sddm.enableGnomeKeyring = true;
      hyprlock.enableGnomeKeyring = true;
    };
  };
}
