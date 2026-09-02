{
  hosts,
  inputs,
  self,
  ...
}:
let
  hostname = "homegrown";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.nixosModules.homegrown =
    { pkgs, self, ... }:
    {
      # This should be an 8 character hex, you can get it via
      # `head -c4 /dev/urandom | od -A none -t x4`
      # It should be unique, and static between builds.
      networking.hostId = "28346cc6";

      # Use `pkgs.linuxPackages` for stable kernel, or `pkgs.linuxPackages_latest` for unstable.
      boot.kernelPackages = pkgs.linuxPackages;

      # System power management: `performance` | `schedutil` | `powersave`
      powerManagement.cpuFreqGovernor = "schedutil";

      # SSH agent is required for headless hosts
      programs.ssh.startAgent = true;

      imports = [
        self.nixosModules.base
        self.nixosModules.media
      ];
    };

  flake.homeModules.homegrown =
    { self, ... }:
    {
      imports = [ self.homeModules.server ];
    };

  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    module = self.nixosModules.homegrown;
    extraModules = [ inputs.copyparty.nixosModules.default ];
  };

  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = self.homeModules.homegrown;
  };
}
