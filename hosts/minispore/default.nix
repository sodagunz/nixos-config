{pkgs, host, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  services.gnome.gnome-keyring.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
