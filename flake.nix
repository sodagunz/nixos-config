{
  description = "sodagunz' nixos-config";

  # This project loosely uses the dendritic configuration.
  # Every file besides this root is a flake parts module which exposes
  # its own configuration.
  # Hosts are configured in `./machines`, where `nixosConfigurations`, `homeConfigurations`,
  # and `darwinConfigurations` are defined for each machine and rely on the rest of the modules.
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.import-tree ./modules)
      ];
    };

  inputs = {
    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ryantm/agenix";
    };
    copyparty.url = "github:9001/copyparty";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager/master";
    };
    import-tree.url = "github:vic/import-tree";

    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    noctalia.url = "github:noctalia-dev/noctalia";
    nvf.url = "github:notashelf/nvf";

  };
}
