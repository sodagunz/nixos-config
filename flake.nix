{
  description = "gunz systems configuration";
  outputs =
    {
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      nvf,
      self,
      ...
    }@inputs:
    let
      hostConfigs = {
        minispore = {
          system = "x86_64-linux";
          username = "gunz";
          extraHostModules = [ ];
        };
        homegrown = {
          system = "x86_64-linux";
          username = "gunz";
          extraHostModules = [ inputs.copyparty.nixosModules.default ];
        };
        filmotheque = {
          system = "x86_64-linux";
          username = "gunz";
          extraHostModules = [ inputs.copyparty.nixosModules.default ];
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
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosHost hostConfigs;

      homeConfigurations."gunz@minispore" =
        let
          hostConfig = hostConfigs.minispore;
          pkgs = import nixpkgs-unstable {
            inherit (hostConfig) system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            host = "minispore";
            inherit (hostConfig) username;
            inherit self inputs;
          };
          modules = [
            nvf.homeManagerModules.default
            ./hosts/minispore/home.nix
            {
              home = {
                username = hostConfig.username;
                homeDirectory = "/home/${hostConfig.username}";
                stateVersion = "25.05";
              };
              programs.home-manager.enable = true;
            }
          ];
        };
    };

  inputs = {
    copyparty.url = "github:9001/copyparty";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager/master";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";

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
