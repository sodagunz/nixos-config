{pkgs, ...}:
{

  environment.systemPackages = with pkgs; [ transmission_4-qt ];

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    settings = {
      download-dir = "/mnt/tank/media";
    };
  };

  services.radarr = {
    enable = true;
    openFirewall = true; # opens 7878
  };

  services.sonarr = {
    enable = true;
    openFirewall = true; # opens 8989
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true; #opens 9696
  };

  users.groups.media.members = [
    "prowlarr"
    "sonarr"
    "radarr"
    "transmission"
  ];
}
