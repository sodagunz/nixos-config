{ pkgs, ... }:
{
  # Install necessary packages
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    # docker-compose # is an alias for podman-compose if podman.dockerCompat is on
    podman-compose
  ];

  # Manage the virtualisation services
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
