{ self, ... }:
{
  flake.nixosModules.server = {
    imports = with self.nixosModules; [
      agenix
      base
      cloudflared
      media
      nas
      torrent
    ];
  };

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
