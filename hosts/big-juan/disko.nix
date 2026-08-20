{ ... }:

let
  btrfsMountOptions = [
    "compress=zstd"
    "noatime"
    "discard=async"
  ];
in
{
  disko.devices = {
    disk.main = {
      type = "disk";

      device = "/dev/disk/by-id/nvme-Samsung_SSD_990_EVO_Plus_4TB_S7U8NJ0Y108106R";

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";

              mountOptions = [
                "umask=0077"
              ];
            };
          };

          cryptsystem = {
            size = "100%";

            content = {
              type = "luks";
              name = "cryptsystem";

              passwordFile = "/tmp/disko-password";

              settings = {
                allowDiscards = true;
              };

              content = {
                type = "lvm_pv";
                vg = "system";
              };
            };
          };
        };
      };
    };

    lvm_vg.system = {
      type = "lvm_vg";

      lvs = {
        swap = {
          size = "72G";

          content = {
            type = "swap";
            resumeDevice = true;
          };
        };

        root = {
          size = "100%FREE";

          content = {
            type = "btrfs";

            extraArgs = [
              "-f"
            ];

            subvolumes = {
              "/root" = {
                mountpoint = "/";
                mountOptions = btrfsMountOptions;
              };

              "/home" = {
                mountpoint = "/home";
                mountOptions = btrfsMountOptions;
              };

              "/nix" = {
                mountpoint = "/nix";
                mountOptions = btrfsMountOptions;
              };

              "/log" = {
                mountpoint = "/var/log";
                mountOptions = btrfsMountOptions;
              };

              "/snapshots" = {
                mountpoint = "/.snapshots";
                mountOptions = btrfsMountOptions;
              };
            };
          };
        };
      };
    };
  };
}
