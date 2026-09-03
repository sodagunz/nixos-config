{ self, ... }:
{
  flake.homeModules.base =
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
        perl
        python3
        ripgrep
        shellcheck
        unzip
        xxd
      ];
      imports = [
        self.homeModules.helix
        self.homeModules.zellij
      ];
    };

  flake.nixosModules.base = {
    imports = with self.nixosModules; [
      agenix
      bootloader
      cachix
      comin
      networking
      nh
      programs
      core
      users
      virtualization
    ];
  };
}
