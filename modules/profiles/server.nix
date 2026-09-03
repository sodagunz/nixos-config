{ self, ... }:
{
  flake.homeModules.server =
    { pkgs, self, ... }:
    {
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
      imports = [
        self.homeModules.helix
        self.homeModules.zellij
      ];
    };
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
}
