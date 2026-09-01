{
  pkgs,
  host,
  config,
  ...
}: {
  boot = {
    initrd = {
      compressor = "xz";
      compressorArgs = [
        "-9e"
        "--check=crc32"
      ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # The EFI system partition is only 96 MiB; keep one rollback generation.
      systemd-boot.configurationLimit = 2;
    };
  };
}
