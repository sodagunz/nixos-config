{ ... }:
{
  flake.nixosModules.virtualization = { pkgs, ... }: {
    # Install necessary packages
    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      # docker-compose # is an alias for podman-compose if podman.dockerCompat is on
      podman-compose
    ];

    # Manage the virtualisation services
    virtualisation.podman = {
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
      enable = true;
    };
  };
}
