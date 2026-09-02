{pkgs, ...}:
{

  environment.systemPackages = with pkgs; [ transmission_4-qt ];

  # networking.firewall.allowedTCPPorts = [9091];

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "0.0.0.0,127.0.0.1,192.168.1.195,192.168.1.200,192.168.1.210";
      download-dir = "/tank/media/raw";
      incomplete-dir = "/tank/media/raw/.incomplete";
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
