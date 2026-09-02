{
  description = "gunz systems configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.import-tree ./flake)
        (inputs.import-tree ./machines)
        (inputs.import-tree ./profiles)
        (inputs.import-tree ./system)
        (inputs.import-tree ./apps)
      ];
    };

  inputs = {
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
