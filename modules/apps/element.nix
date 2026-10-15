{ ... }:
{
  flake.homeModules.element =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.element-desktop ];
    };

  flake.nixosModules.element = {
    # Element uses Secret Service to persist its encrypted session securely.
    services.gnome.gnome-keyring.enable = true;
  };
}
