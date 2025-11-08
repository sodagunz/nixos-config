{
  description = "gunz systems configuration";
  outputs = {
    home-manager,
    nixpkgs,
    nvf,
    self,
    ...
  } @ inputs: {
    nixosConfigurations = let
      nixosHosts = {
        minispore = {
          system = "x86_64-linux";
          username = "gunz";
          extraHostModules = [];
        };
        homegrown = {
          system = "x86_64-linux";
          username = "gunz";
          extraHostModules = [inputs.copyparty.nixosModules.default];
        };
        filmotheque = {
          system = "x86_64-linux";
          username = "gunz";
          extraHostModules = [inputs.copyparty.nixosModules.default];
        };
      };

      mkNixosHost = hostname: hostConfig:
        nixpkgs.lib.nixosSystem {
          modules = [./hosts/${hostname}] ++ hostConfig.extraHostModules;
          inherit (hostConfig) system;
          specialArgs = {
            host = hostname;
            inherit (hostConfig) username;
            homeModules = [./hosts/${hostname}/home.nix];
            inherit self inputs;
          };
        };
    in
      nixpkgs.lib.mapAttrs mkNixosHost nixosHosts;
  };

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra";
    copyparty.url = "github:9001/copyparty";
    ghostty.url = "github:ghostty-org/ghostty";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
