{ inputs, ... }:
{
  _module.args.hosts = {
    mkHome =
      {
        hostname,
        module,
        system,
        username,
      }:
      let
        pkgs = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username inputs;
          host = hostname;
          self = inputs.self;
        };
        modules = [
          inputs.nvf.homeManagerModules.default
          module
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
              stateVersion = "25.05";
            };
            programs.home-manager.enable = true;
          }
        ];
      };
    mkNixos =
      {
        extraModules ? [ ],
        hostname,
        module,
        system,
        username,
      }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ module ] ++ extraModules;
        specialArgs = {
          inherit username inputs;
          host = hostname;
          self = inputs.self;
        };
      };
  };
}
