_: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/default.server.nix
  ];

  powerManagement.cpuFreqGovernor = "schedutil";
  programs.ssh.startAgent = true;
}
