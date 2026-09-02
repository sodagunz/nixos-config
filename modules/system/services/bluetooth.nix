{ ... }:
{
  flake.nixosModules.bluetooth = { pkgs, ... }: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    environment.systemPackages = with pkgs; [ blueman ];

    services.blueman.enable = true;
  };
}
