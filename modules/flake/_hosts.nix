{ inputs }:
{
  mkNixos =
    {
      hostname,
      system,
      username,
      module,
      extraModules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ module ] ++ extraModules;
      specialArgs = {
        host = hostname;
        inherit username inputs;
        self = inputs.self;
      };
    };

  mkHome =
    {
      hostname,
      system,
      username,
      module,
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
        host = hostname;
        inherit username inputs;
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
}
