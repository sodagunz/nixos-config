{
  hosts,
  inputs,
  self,
  ...
}:
let
  hostname = "filmotheque";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = self.homeModules.filmotheque;
  };
  flake.homeModules.filmotheque =
    { self, ... }:
    {
      imports = [ self.homeModules.base ];
    };
  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    extraModules = [
      inputs.copyparty.nixosModules.default
    ];
    module = self.nixosModules.filmotheque;
  };
  flake.nixosModules.filmotheque =
    {
      config,
      pkgs,
      self,
      ...
    }:
    {
      age.secrets."comin-github.token" = {
        file = ../../.secrets/comin-github.token.age;
        mode = "0400";
      };
      age.secrets.filmotheque-cloudflared-token = {
        file = ../../.secrets/filmotheque-cloudflared.token.age;
        mode = "0400";
      };
      age.secrets.nextcloud-admin-password = {
        file = ../../.secrets/nextcloud-admin-password.age;
        group = "nextcloud";
        mode = "0400";
        owner = "nextcloud";
      };
      # Set up zfs
      # TODO: make this a module and parameterize pools?
      boot = {
        supportedFilesystems = [ "zfs" ];
        zfs = {
          devNodes = "/dev/disk/by-id";
          extraPools = [ "tank" ];
          forceImportRoot = false;
          package = pkgs.zfs;
        };
      };
      # Use `pkgs.linuxPackages` for stable kernel, or `pkgs.linuxPackages_latest` for unstable.
      boot.kernelPackages = pkgs.linuxPackages; # ZFS usually lags behind latest
      environment.systemPackages = [ pkgs.smartmontools ];
      imports = with self.nixosModules; [
        base
        cloudStorage
        cloudflared
        media
        nas
        torrent
      ];
      # This should be an 8 character hex, you can get it via
      # head -c4 /dev/urandom | od -A none -t x4
      # It should be unique, and static between builds.
      networking.hostId = "83a73ad2";
      # System power management: `performance` | `schedutil` | `powersave`
      powerManagement.cpuFreqGovernor = "schedutil";
      # SSH agent is required for headless hosts
      programs.ssh.startAgent = true;
      # Set up smart monitoring
      # TODO: make this a module and parameterize drive names?
      services.smartd = {
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
        enable = true;
      };
      services.zfs = {
        autoScrub = {
          enable = true;
          interval = "weekly";
        };

        autoSnapshot.enable = false;
      };
      sodagunz.services.cloudflared = {
        enable = true;
        tokenFile = config.age.secrets.filmotheque-cloudflared-token.path;
        tunnelId = "ae4102f8-f139-456d-9d33-f5d85ce06030";
      };
    };
}
