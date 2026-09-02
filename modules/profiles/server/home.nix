{ ... }:
{
  flake.homeModules.server =
    { self, pkgs, ... }:
    {
      imports = [
        self.homeModules.helix
        self.homeModules.zellij
      ];

      home.packages = with pkgs; [
        entr
        eza
        fd
        file
        hexdump
        jq
        killall
        ripgrep
        unzip
        xxd
        python3
        perl
        shellcheck
      ];
    };
}
