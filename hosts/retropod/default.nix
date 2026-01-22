{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/bootloader.nix
    ./../../modules/core/hardware.nix
    ./../../modules/core/network.nix
    ./../../modules/core/nh.nix
    ./../../modules/core/program.nix
    ./../../modules/core/system.nix
    ./../../modules/core/user.nix
    ./../../modules/core/pipewire.nix
    ./../../modules/core/bluetooth.nix
  ];

  powerManagement.cpuFreqGovernor = "schedutil";
  programs.ssh.startAgent = true;
  boot.kernelPackages = pkgs.linuxPackages;

  environment.systemPackages = with pkgs; [
    retroarch
  ];

  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "${username}";
      };
    };
    desktopManager = {
      retroarch = {
        enable = true;
        package = pkgs.retroarch.override {
          cores = with pkgs.libretro; [
            genesis-plus-gx
            snes9x
            beetle-psx-hw
            mupen64plus
            mgba
            nestopia
            fbneo
          ];
        };
      };
    };
  };
}
