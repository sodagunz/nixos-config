{ pkgs, self, ... }:
{
  # This should be an 8 character hex, you can get it via
  # head -c4 /dev/urandom | od -A none -t x4
  # It should be unique, and static between builds.
  networking.hostId = "be02bace";

  boot.kernelPackages = pkgs.linuxPackages;

  # System power management: `performance` | `schedutil` | `powersave`
  powerManagement.cpuFreqGovernor = "schedutil";

  # Replaces SSH agent workstations.
  services.gnome.gnome-keyring.enable = true;

  # NAS client configuration
  # TODO: replace with hostname, maybe parameterize path?
  environment.systemPackages = with pkgs; [ nfs-utils ];
  fileSystems."/mnt/tank" = {
    device = "192.168.1.195:/mnt/tank";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "_netdev"
    ];
  };

  # Use default core modules for workstations.
  imports = [
    ./hardware-configuration.nix
    self.nixosModules.workstation
  ];
}
