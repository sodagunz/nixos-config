{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.server.nix
    ./../../modules/core/nas.nix
  ];

  powerManagement.cpuFreqGovernor = "schedutil";
  programs.ssh.startAgent = true;

  boot = {
    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["tank"];
      package = pkgs.zfs;
      devNodes = "/dev/disk/by-id";
    };
    # ZFS usually lags behind latest
    kernelPackages = pkgs.linuxPackages;
  };
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
    };


    autoSnapshot.enable = false;
  };


  # This should be an 8 character hex, you can get it via
  # head -c4 /dev/urandom | od -A none -t x4
  # It should be unique, and static between builds.
  networking.hostId = "83a73ad2";

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

  environment.systemPackages = [pkgs.smartmontools];
}
