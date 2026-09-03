{ ... }:
{
  flake.nixosModules.flatpak =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

      services.flatpak = {
        enable = true;
        overrides = {
          global = {
            # Force Wayland by default
            Context.sockets = [
              "wayland"
              "!x11"
              "!fallback-x11"
            ];
          };
        };
        packages = [
          # "io.github.zen_browser.zen"
          "com.github.tchx84.Flatseal"
          "io.github.everestapi.Olympus"
        ];
      };
    };
}
