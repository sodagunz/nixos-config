_: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
      systemd-boot = {
        enable = true;
        xbootldrMountPoint = "/boot";
      };
      # Five rollback generations fit comfortably on the 2 GiB XBOOTLDR partition.
      systemd-boot.configurationLimit = 5;
    };
  };
}
