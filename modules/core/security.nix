{ ... }:
{
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.hyprlock = { };
}
