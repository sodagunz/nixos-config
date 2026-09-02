{ ... }:
{
  flake.nixosModules.nas = _: {
    services.nfs.server = {
      enable = true;
      exports = ''
        /tank 192.168.1.0/24 (rw, sync, no_root_squash)
      '';
    };

    networking.firewall.allowedTCPPorts = [ 2049 ];
  };
}
