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
          device = "/dev/disk/by-id/ata-TOSHIBA_MG08ACA16TE_51S0A6CMFVGG";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              zfs = {
                size = "100%";
                # type = "8300";  # Linux filesystem type; you may also use "BF01" or specific ZFS type
                label = "zfs-hdd1";
                content = {
                  type = "zfs";
                  pool = "tank";
                };
              };
            };
          };
        };

        hdd2 = {
          device = "/dev/disk/by-id/ata-TOSHIBA_MG08ACA16TE_51S0A6X5FVGG";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              zfs = {
                size = "100%";
                # type = "8300";
                label = "zfs-hdd2";
                content = {
                  type = "zfs";
                  pool = "tank";
                };
              };
            };
          };
        };
      };

      zpool = {
        tank = {
          type = "zpool";
          rootFsOptions = {
            compression = "lz4";
            atime = "off";
            xattr = "sa";
            acltype = "posixacl";
          };

          mode = {
            topology = {
              type = "topology";
              vdev = [
                {
                  mode = "mirror";
                  members = [
                    "/dev/disk/by-partlabel/zfs-hdd1"
                    "/dev/disk/by-partlabel/zfs-hdd2"
                  ];
                }
              ];
            };
          };

          datasets = {
            "tank/data" = {
              type = "zfs_fs";
              mountpoint = "/tank/data";
              options = {
                recordsize = "128K";
              };
            };

            "tank/backups" = {
              type = "zfs_fs";
              mountpoint = "/tank/backups";
              options = {
                recordsize = "1M";
              };
            };

            "tank/media" = {
              type = "zfs_fs";
              mountpoint = "/tank/media";
              options = {
                recordsize = "1M";
              };
            };
          };
        };
      };
    };
  };
}
