{ ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./networking.nix

    ../../modules/shared/base.nix
    ../../modules/shared/base-desktop.nix
    ../../modules/shared/desktop-packages.nix
    ../../modules/shared/steam.nix
  ];

  boot = {
    initrd = {
      systemd.enable = true;
      secrets."/etc/keys/root.key" = null;

      luks.devices.cryptsystem = {
        keyFile = "/etc/keys/root.key";
      };
    };

    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;

        # Only generate /boot/grub/grub.cfg.
        # GRUB itself is Libreboot's flash-resident GRUB.
        device = "nodev";

        enableCryptodisk = true;
        configurationLimit = 10;

        extraConfig = ''
          terminal_input console
          terminal_output console
        '';
      };
    };
  };

  system.stateVersion = "26.05";
}
