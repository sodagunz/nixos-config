{ ... }:
{
  flake.homeModules.element =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.element-desktop.override {
          commandLineArgs = "--password-store=gnome-libsecret";
        })
      ];
    };

  flake.nixosModules.element = {
    # Element uses Secret Service to persist its encrypted session securely.
    services.gnome.gnome-keyring.enable = true;
  };
}
