{ ... }:
{
  flake.nixosModules.filmotheque =
    {
      config,
      pkgs,
      self,
      ...
    }:
    {

      age.secrets.filmotheque-cloudflared-token = {
        file = ../../../.secrets/filmotheque-cloudflared.token.age;
        mode = "0400";
      };

      sodagunz.services.cloudflared = {
        enable = true;
        tunnelId = "ae4102f8-f139-456d-9d33-f5d85ce06030";
        tokenFile = config.age.secrets.filmotheque-cloudflared-token.path;
      };

      # This should be an 8 character hex, you can get it via
      # head -c4 /dev/urandom | od -A none -t x4
      # It should be unique, and static between builds.
      networking.hostId = "83a73ad2";

      # System power management: `performance` | `schedutil` | `powersave`
      powerManagement.cpuFreqGovernor = "schedutil";

      # Use `pkgs.linuxPackages` for stable kernel, or `pkgs.linuxPackages_latest` for unstable.
      boot.kernelPackages = pkgs.linuxPackages; # ZFS usually lags behind latest

      # SSH agent is required for headless hosts
      programs.ssh.startAgent = true;

      # Set up zfs
      # TODO: make this a module and parameterize pools?
      boot = {
        supportedFilesystems = [ "zfs" ];
        zfs = {
          forceImportRoot = false;
          extraPools = [ "tank" ];
          package = pkgs.zfs;
          devNodes = "/dev/disk/by-id";
        };
      };
      services.zfs = {
        autoScrub = {
          enable = true;
          interval = "weekly";
        };

        autoSnapshot.enable = false;
      };

      # Set up smart monitoring
      # TODO: make this a module and parameterize drive names?
      services.smartd = {
        enable = true;
        autodetect = true;
        devices = [
          {
            device = "/dev/disk/by-id/ata-TOSHIBA_MG08ACA16TE_51S0A6CMFVGG";
            options = "-a -o on -S on -s S(/../.././02|L/../../7/03)";
          }
          {
            device = "/dev/disk/by-id/ata-TOSHIBA_MG08ACA16TE_51S0A6X5FVGG";
            options = "-a -o on -S on -s S(/../.././02|L/../../7/03)";
          }
        ];
      };
      environment.systemPackages = [ pkgs.smartmontools ];

      # Enable modules as needed for server specialization
      imports = [
        self.nixosModules.server
      ];

    };
}
