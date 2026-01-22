{
  pkgs,
  username,
  ...
}:
let
  retroarch-custom = pkgs.retroarch.withCores(
    cores: with cores; [
      fbneo
      mame2016
      puae
      dosbox-pure
      beetle-pce
      gambatte
      mgba
      beetle-vb
      melonds
      nestopia
      snes9x
      mupen64plus
      scummvm
      genesis-plus-gx
      picodrive
      beetle-saturn
      flycast
      pcsx-rearmed
      pcsx2
      dolphin
      citra
    ]);
in
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

  networking.hostId = "7cf0ec96";

  environment.systemPackages = with pkgs; [
    retroarch-custom
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
        package = retroarch-custom;
      };
    };
  };
}
