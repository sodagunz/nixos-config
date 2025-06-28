{
  # Add binary caches to speed up builds.
  nix = {
    settings = {
      extra-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMIOdOz0G3y5b41mWdeA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nb3cLGAY654eA+n32e6O01B3I3u3M7auO1y0mLxXn2Q="
      ];
    };
  };
}
