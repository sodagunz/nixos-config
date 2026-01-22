{
  description = "gunz systems configuration";
  outputs =
    {
      home-manager,
      nixpkgs,
      self,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          nixosHosts = {
            minispore = {
              system = "x86_64-linux";
              username = "gunz";
              extraHostModules = [ ];
            };
            filmotheque = {
              system = "x86_64-linux";
              username = "gunz";
              extraHostModules = [inputs.copyparty.nixosModules.default];
            };
            retropod = {
              system = "x86_64-linux";
              username = "gunz";
              extraHostModules = [inputs.copyparty.nixosModules.default];
            };
          };

          mkNixosHost =
            hostname: hostConfig:
            nixpkgs.lib.nixosSystem {
              modules = [ ./hosts/${hostname} ] ++ hostConfig.extraHostModules;
              inherit (hostConfig) system;
              specialArgs = {
                host = hostname;
                inherit (hostConfig) username;
                inherit self inputs;
              };
            };
        in
        nixpkgs.lib.mapAttrs mkNixosHost nixosHosts;

      homeConfigurations =
        let
          homeHosts = {
            "gunz@minispore" = {
              system = "x86_64-linux";
              username = "gunz";
              homeModules = [ ./hosts/minispore/home.nix ];
            };
            "gunz@filmotheque" = {
              system = "x86_64-linux";
              username = "gunz";
              homeModules = [ ./hosts/filmotheque/home.nix ];
            };
            "gunz@retropod" = {
              system = "x86_64-linux";
              username = "gunz";
              homeModules = [ ./hosts/retropod/home.nix ];
            };
          };

          mkHomeHost =
            hostname: hostConfig:
            home-manager.lib.homeManagerConfiguration {
              pkgs = import inputs.nixpkgs-unstable {
                system = hostConfig.system;
                config.allowUnfree = true;
              };
              extraSpecialArgs = {
                inherit inputs self;
                host = hostname;
                username = hostConfig.username;
              };
              modules = [
                {
                  home = {
                    inherit (hostConfig) username;
                    homeDirectory = "/home/${hostConfig.username}";
                    stateVersion = "25.11";
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
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager";
    };

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprmag.url = "github:SIMULATAN/hyprmag";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-plugins = {
      flake = false;
      url = "github:yazi-rs/plugins";
    };
  };
}
