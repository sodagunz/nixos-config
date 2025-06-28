{
  description = "Guinz NixOS configuration";
  outputs = {
    nixpkgs,
    self,
    flake-parts,
    ...
  } @ inputs: let
    username = "gunz";
  in
    flake-parts.lib.mkFlake {
      inherit inputs;
    } {
      # Use any system
      systems = import inputs.systems;

      flake = {
        nixosConfigurations = {
          desktop = nixpkgs.lib.nixosSystem {
            modules = [./hosts/desktop];
            specialArgs = {
              host = "desktop";
              inherit self inputs username;
            };
          };
        };

        perSystem = {pkgs, ...}: {
          formatter = pkgs.alejandra;

          checks = {
            nix-fmt = pkgs.runCommand "nix-fmt-check" {nativeBuildInputs = [pkgs.alejandra];} ''
              alejandra --check ${self} < /dev/null | tee $out
            '';
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    ghostty.url = "github:ghostty-org/ghostty";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    hyprland = {
      type = "git";
      submodules = true;
      url = "https://github.com/hyprwm/Hyprland";
    };

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprmag.url = "github:SIMULATAN/hyprmag";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nur.url = "github:nix-community/NUR";
    nvf.url = "github:notashelf/nvf/af0cc1a85675e3a0dedb15ce648344c52d15c8d8";

    spicetify-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:gerg-l/spicetify-nix";
    };

    yazi-plugins = {
      flake = false;
      url = "github:yazi-rs/plugins";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
}
