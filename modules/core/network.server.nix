{
  pkgs,
  host,
  username,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
      "8.8.4.4"
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        3923
        59010
        59011
      ];
      allowedUDPPorts = [
        3923
        59010
        59011
      ];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet unbound];

  users.users.unbound = {};
  users.groups.netmgmt.members = ["unbound" "${username}"];

  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = ["127.0.0.1"];
        port = 5355;
        access-control = ["192.168.1.0/24 allow" "127.0.0.1/8 allow"];

        harden-glue = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        prefetch = true;
        edns-buffer-size = 1232;

        hide-identity = true;
        hide-version = true;

        domain-insecure = ["homegrown.lab" "minispore.lab"];
        local-zone = ["lab. static"];
        local-data = ["homegrown. A 192.168.1.204" "minispore. A 192.168.1.200"];
      };

        forward-zone = [
          {
            name = ".";
            forward-addr = [
              "9.9.9.9"
              "1.1.1.1"
              "8.8.8.8"
            ];
            forward-tls-upstream = true;
          }
        ];
    };
  };
}
