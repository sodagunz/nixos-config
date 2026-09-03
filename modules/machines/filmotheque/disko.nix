{ ... }:
{
  flake.nixosModules.filmotheque-disko = {
    disko.devices = {
      disk = {
        # ssd = {
        #   device = "/dev/disk/by-id/ata-KINGSTON_SA400S37240G_50026B73840CA530";
        #   type = "disk";
        #   content = {
        #     type = "gpt";
        #     partitions = {
        #       ESP = {
        #         size = "1G";
        #         type = "EF00";
        #         content = {
        #           type = "filesystem";
        #           format = "vfat";
        #           mountpoint = "/boot";
        #         };
        #       };

        #       swap = {
        #         size = "32G";
        #         type = "8200";
        #         content = {
        #           type = "swap";
        #         };
        #       };

        #       root = {
        #         size = "100%";
        #         type = "8300";
        #         content = {
        #           type = "filesystem";
        #           format = "ext4";
        #           mountpoint = "/";
        #         };
        #       };
        #     };
        #   };
        # };
        hdd1 = {
          content = {
            partitions = {
              zfs = {
                content = {
                  pool = "tank";
                  type = "zfs";
                };
                # type = "8300";  # Linux filesystem type; you may also use "BF01" or specific ZFS type
                label = "zfs-hdd1";
                size = "100%";
              };
            };
            type = "gpt";
          };
          device = "/dev/disk/by-id/ata-TOSHIBA_MG08ACA16TE_51S0A6CMFVGG";
          type = "disk";
        };

        hdd2 = {
          content = {
            partitions = {
              zfs = {
                content = {
                  pool = "tank";
                  type = "zfs";
                };
                # type = "8300";
                label = "zfs-hdd2";
                size = "100%";
              };
            };
            type = "gpt";
          };
          device = "/dev/disk/by-id/ata-TOSHIBA_MG08ACA16TE_51S0A6X5FVGG";
          type = "disk";
        };
      };

      zpool = {
        tank = {
          datasets = {
            "tank/backups" = {
              mountpoint = "/tank/backups";
              options = {
                recordsize = "1M";
              };
              type = "zfs_fs";
            };
            "tank/data" = {
              mountpoint = "/tank/data";
              options = {
                recordsize = "128K";
              };
              type = "zfs_fs";
            };
            "tank/media" = {
              mountpoint = "/tank/media";
              options = {
                recordsize = "1M";
              };
              type = "zfs_fs";
            };
          };
          mode = {
            topology = {
              type = "topology";
              vdev = [
                {
                  members = [
                    "/dev/disk/by-partlabel/zfs-hdd1"
                    "/dev/disk/by-partlabel/zfs-hdd2"
                  ];
                  mode = "mirror";
                }
              ];
            };
          };
          rootFsOptions = {
            acltype = "posixacl";
            atime = "off";
            compression = "lz4";
            xattr = "sa";
          };
          type = "zpool";
        };
      };
    };
  };
}
