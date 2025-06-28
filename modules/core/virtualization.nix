{
  config,
  pkgs,
  username,
  ...
}: {
  # Add user to libvirtd group
  users.users.${username}.extraGroups = ["libvirtd"];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    adwaita-icon-theme

    dive
    podman-tui
    docker-compose
    podman-compose
  ];

  # Manage the virtualisation services
  virtualisation = {
    containers.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;
}
