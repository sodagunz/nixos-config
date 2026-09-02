{ ... }:
{
  flake.nixosModules.bootloader = _: {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };
  };
}
