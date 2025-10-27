{
  description = "Guinz NixOS configuration";
  outputs = {
    home-manager,
    nixpkgs,
    nvf,
    self,
    ...
  } @ inputs: let
    # Nvf setup works differently on hm and on nixos modules.
    hmNvim = nvf.lib.neovimConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [./modules/home/hm-nvim.nix];
    };
  in {
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

    # Workaround for not being able to use nix-darwin on one of my systems:
    homeConfigurations."tomas.guiznburg" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [
        {home.packages = [hmNvim.neovim];}
      ];
    };
  };

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra";
    copyparty.url = "github:9001/copyparty";
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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
