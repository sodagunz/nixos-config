{ ... }:
{
  flake.homeModules.fish = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

        alias wrk "cd ~/Workspace"
      '';
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fetchFromGitHub {
            hash = "sha256-p7vvwisu3mvVOE1DcALbzuGJqWBcE1h71UjaopGdxE0=";
            owner = "jhillyerd";
            repo = "plugin-git";
            rev = "e4897db7abd43a74c902b5000c535b9da6ff766e";
          };
        }
      ];
    };
  };
}
