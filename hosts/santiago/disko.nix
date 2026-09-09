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

      device = "/dev/disk/by-id/INSERT_SSD_HERE";

      content = {
        type = "gpt";

        partitions = {
          cryptsystem = {
            size = "100%";

            content = {
              type = "luks";
              name = "cryptsystem";

              passwordFile = "/tmp/disko-password";

              extraFormatArgs = [
                "--type"
                "luks2"
                "--pbkdf"
                "argon2id"
              ];

              settings = {
                allowDiscards = true;
              };

              additionalKeyFiles = [
                "/tmp/root.key"
              ];

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
