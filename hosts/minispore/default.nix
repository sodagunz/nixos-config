{
  pkgs,
  host,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  services.gnome.gnome-keyring.enable = true;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  powerManagement.cpuFreqGovernor = "schedutil";
  boot.kernelPackages = pkgs.linuxPackages;

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
  environment.systemPackages = with pkgs; [
    nfs-utils
    home-manager
  ];
}
