{
  inputs,
  lib,
  ...
}:
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
    inputs.nixpkgs.lib.nixosSystem {
      modules = [ ../../hosts/${hostname} ] ++ hostConfig.extraHostModules;
      inherit (hostConfig) system;
      specialArgs = {
        host = hostname;
        inherit (hostConfig) username;
        self = inputs.self;
        inherit inputs;
      };
    };
in
{
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    default = { };
    description = "Home Manager modules exported by feature modules.";
  };

  config.flake = {
    nixosConfigurations = inputs.nixpkgs.lib.mapAttrs mkNixosHost hostConfigs;

    homeConfigurations."gunz@minispore" =
      let
        hostConfig = hostConfigs.minispore;
        pkgs = import inputs.nixpkgs-unstable {
          inherit (hostConfig) system;
          config.allowUnfree = true;
        };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          host = "minispore";
          inherit (hostConfig) username;
          self = inputs.self;
          inherit inputs;
        };
        modules = [
          inputs.nvf.homeManagerModules.default
          ../../hosts/minispore/home.nix
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
}
