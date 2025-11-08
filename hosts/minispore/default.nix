{pkgs, ...}: {
  # This should be an 8 character hex, you can get it via
  # head -c4 /dev/urandom | od -A none -t x4
  # It should be unique, and static between builds.
  networking.hostId = "be02bace";

  # Use `pkgs.linuxPackages` for stable kernel, or `pkgs.linuxPackages_latest` for unstable. 
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # System power management: `performance` | `schedutil` | `powersave`
  powerManagement.cpuFreqGovernor = "schedutil";

  # Replaces SSH agent workstations.
  services.gnome.gnome-keyring.enable = true;

  # NAS client configuration
  # TODO: replace with hostname, maybe parameterize path?
  environment.systemPackages = with pkgs; [nfs-utils];
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

  # Use default core modules for workstations.
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/workstation
  ];
}
