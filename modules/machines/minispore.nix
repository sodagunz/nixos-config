{
  hosts,
  self,
  ...
}:
let
  hostname = "minispore";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.nixosModules.minispore =
    { pkgs, self, ... }:
    {
      # This should be an 8 character hex, you can get it via
      # head -c4 /dev/urandom | od -A none -t x4
      # It should be unique, and static between builds.
      networking.hostId = "be02bace";

      boot.kernelPackages = pkgs.linuxPackages;

      boot.loader = {
        efi.efiSysMountPoint = "/efi";
        systemd-boot = {
          xbootldrMountPoint = "/boot";
          # Five rollback generations fit comfortably on the 2 GiB XBOOTLDR partition.
          configurationLimit = 5;
        };
      };

      # System power management: `performance` | `schedutil` | `powersave`
      powerManagement.cpuFreqGovernor = "schedutil";

      # Replaces SSH agent workstations.
      # services.gnome.gnome-keyring.enable = true;

      # NAS client configuration
      # TODO: replace with hostname, maybe parameterize path?
      # environment.systemPackages = with pkgs; [ nfs-utils ];
      # fileSystems."/mnt/tank" = {
      #   device = "192.168.1.195:/mnt/tank";
      #   fsType = "nfs";
      #   options = [
      #     "x-systemd.automount"
      #     "noauto"
      #     "_netdev"
      #   ];
      # };

      imports = [ self.nixosModules.workstation ];
    };

  flake.homeModules.minispore =
    { self, ... }:
    {
      imports = [ self.homeModules.workstation ];
    };

  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    module = self.nixosModules.minispore;
  };

  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = self.homeModules.minispore;
  };
}
