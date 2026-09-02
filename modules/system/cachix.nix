{ ... }:
{
  flake.nixosModules.cachix = {
    # Add binary caches to speed up builds.
    nix = {
      settings = {
        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nb3cLGAY654eA+n32e6O01B3I3u3M7auO1y0mLxXn2Q="
        ];
      };
    };
  };
}
