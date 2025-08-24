{
  pkgs,
  host,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    kernelPackages =
      if host == "homegrown"
      then pkgs.linuxPackages
      else pkgs.linuxPackages_latest;
  };
}
