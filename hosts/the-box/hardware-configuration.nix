{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ata_generic" "ehci_pci" "ahci" "xhci_pci" "usbhid" "ums_realtek" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "btrfs" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;

      mirroredBoots = [
        {
          path = "/boot";
          devices = [ "nodev" ];
        }

        {
          path = "/boot2";
          devices = [ "nodev" ];
        }
      ];
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e3db1f19-c25b-4d57-97e9-ab1ef72964e7";
    fsType = "btrfs";
    options = [ "subvol=@root" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/e3db1f19-c25b-4d57-97e9-ab1ef72964e7";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/e3db1f19-c25b-4d57-97e9-ab1ef72964e7";
    fsType = "btrfs";
    options = [ "subvol=@var" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e3db1f19-c25b-4d57-97e9-ab1ef72964e7";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/e3db1f19-c25b-4d57-97e9-ab1ef72964e7";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B50A-5805";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/boot2" = {
    device = "/dev/disk/by-uuid/B5B0-1C4B";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "nofail" ];
  };


  fileSystems."/srv/vault/files" = {
    device = "/dev/disk/by-uuid/a0836c57-f942-4e74-b673-90f723964736";
    fsType = "btrfs";
    options = [ "subvol=@files" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/srv/vault/media" = {
    device = "/dev/disk/by-uuid/a0836c57-f942-4e74-b673-90f723964736";
    fsType = "btrfs";
    options = [ "subvol=@media" "compress=zstd:1" "noatime" ];
  };

  fileSystems."/srv/vault/backups" = {
    device = "/dev/disk/by-uuid/a0836c57-f942-4e74-b673-90f723964736";
    fsType = "btrfs";
    options = [ "subvol=@backups" "compress=zstd:3" "noatime" ];
  };

  fileSystems."/srv/vault/.snapshots" = {
    device = "/dev/disk/by-uuid/a0836c57-f942-4e74-b673-90f723964736";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" "compress=zstd:3" "noatime" ];
  };


  fileSystems."/srv/apps/appdata" = {
    device = "/dev/disk/by-uuid/3f6692c1-4cad-4fce-a5c8-dc5ca4c8e45a";
    fsType = "btrfs";
    options = [ "subvol=@appdata" "compress=zstd:3" "noatime" "discard=async" ];
  };

  fileSystems."/srv/apps/databases" = {
    device = "/dev/disk/by-uuid/3f6692c1-4cad-4fce-a5c8-dc5ca4c8e45a";
    fsType = "btrfs";
    options = [ "subvol=@databases" "compress=zstd:1" "noatime" "discard=async" ];
  };

  fileSystems."/srv/apps/.snapshots" = {
    device = "/dev/disk/by-uuid/3f6692c1-4cad-4fce-a5c8-dc5ca4c8e45a";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" "compress=zstd:3" "noatime" "discard=async" ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
