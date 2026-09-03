{ ... }:
{
  flake.nixosModules.torrent =
    { pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [ transmission_4-qt ];
      services.prowlarr = {
        enable = true;
        openFirewall = true; # opens 9696
      };
      services.radarr = {
        enable = true;
        openFirewall = true; # opens 7878
      };
      services.sonarr = {
        enable = true;
        openFirewall = true; # opens 8989
      };
      # networking.firewall.allowedTCPPorts = [9091];
      services.transmission = {
        enable = true;
        openRPCPort = true;
        package = pkgs.transmission_4;
        settings = {
          download-dir = "/tank/media/raw";
          incomplete-dir = "/tank/media/raw/.incomplete";
          rpc-bind-address = "0.0.0.0";
          rpc-whitelist = "0.0.0.0,127.0.0.1,192.168.1.195,192.168.1.200,192.168.1.210";
        };
      };
      users.groups.media.members = [
        "prowlarr"
        "sonarr"
        "radarr"
        "transmission"
      ];
    };
}
