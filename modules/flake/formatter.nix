{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.pedantix.flakeModules.default
  ];

  perSystem =
    { inputs', lib, ... }:
    {
      packages.pedantix = inputs'.pedantix.packages.default;
      treefmt = {
        programs = {
          kdlfmt.enable = true;
          pedantix.enable = true;
          shfmt.enable = true;
          taplo.enable = true;
          yamlfmt.enable = true;
        };
        projectRootFile = "flake.nix";
        settings = {
          excludes = [
            "*.css"
            "*.jpg"
            "*.json"
            "*.lock"
            "*.md"
            "*.png"
            "*.tmTheme"
            "*.webp"
            "*.zip"
            "*.zsh"
            "LICENSE"
          ];
          formatter = {
            kdlfmt.options = lib.mkForce [ "format" ];
            shfmt.options = lib.mkForce [
              "-l"
              "-w"
              "-ci"
              "-sr"
              "-i"
              "4"
            ];
            taplo.options = lib.mkForce [
              "fmt"
              "-o"
              "align_entries=true"
              "-o"
              "reorder_keys=true"
            ];
          };
        };
      };
    };
}
