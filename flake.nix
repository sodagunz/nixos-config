{
  description = "gunz systems configuration";
  outputs = {
    home-manager,
    nixpkgs,
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
            inherit self inputs;
          };
        };
    in
      nixpkgs.lib.mapAttrs mkNixosHost nixosHosts;

    homeConfigurations = let
      homeHosts = {
        minispore = {
          system = "x86_64-linux";
          username = "gunz";
          homeModules = [./hosts/minispore/home.nix];
        };
        filmotheque = {
          system = "x86_64-linux";
          username = "gunz";
          homeModules = [./hosts/filmotheque/home.nix];
        };
      };

      mkHomeHost = hostname: hostConfig:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = hostConfig.system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit inputs self;
            host = hostname;
            username = hostConfig.username;
          };
          modules =
            [
              {
                home = {
                  inherit (hostConfig) username;
                  homeDirectory = "/home/${hostConfig.username}";
                  stateVersion = "25.05";
                };
                programs.home-manager.enable = true;
              }
            ]
            ++ hostConfig.homeModules;
        };
    in
      nixpkgs.lib.mapAttrs mkHomeHost homeHosts;
  };

  inputs = {
    copyparty.url = "github:9001/copyparty";
    ghostty.url = "github:ghostty-org/ghostty";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprmag.url = "github:SIMULATAN/hyprmag";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    spicetify-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:gerg-l/spicetify-nix";
    };

    yazi-plugins = {
      flake = false;
      url = "github:yazi-rs/plugins";
    };
  };
}
