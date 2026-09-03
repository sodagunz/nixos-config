{ ... }:
{
  flake.nixosModules.networking =
    {
      host,
      ...
    }:
    {
      networking = {
        firewall = {
          allowedTCPPorts = [
            22
            80
            443
            59010
            59011
          ];
          allowedUDPPorts = [
            59010
            59011
          ];
          enable = true;
        };
        hostName = "${host}";
        nameservers = [
          "8.8.8.8"
          "1.1.1.1"
          "8.8.4.4"
        ];
        networkmanager.enable = true;
      };
    };
}
