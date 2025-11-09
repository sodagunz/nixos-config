{pkgs, ...}:
{

  environment.systemPackages = with pkgs; [ transmission_4-qt ];

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    settings = {
      download-dir = "/mnt/tank/media";
      watch-dir = "/mnt/tank/data/torrents";
    };
  };

  services.radarr = {
    enable = true;
    openFirewall = true; # opens 7878
    group = "media";
    dataDir = "/mnt/tank/data/torrents";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true; # opens 8989
    group = "media";
    dataDir = "/mnt/tank/data/torrents";
  };
}
