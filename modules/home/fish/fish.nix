{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fetchFromGitHub {
          owner = "jhillyerd";
          repo = "plugin-git";
          rev = "e4897db7abd43a74c902b5000c535b9da6ff766e";
          hash = "sha256-p7vvwisu3mvVOE1DcALbzuGJqWBcE1h71UjaopGdxE0=";
        };
      }
    ];
  };
}
