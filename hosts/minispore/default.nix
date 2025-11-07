{
  pkgs,
  host,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  services.gnome.gnome-keyring.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.mounts = [
    {
      what = "192.168.1.195:/mnt/tank/data";
      where = "/mnt/nas";
      type = "nfs";
      options = "x-systemd.automount,_netdev";
    }
  ];

  systemd.automounts = [
    {
      where = "/mnt/nas";
    }
  ];
  environment.systemPackages = with pkgs; [nfs-utils];
}
