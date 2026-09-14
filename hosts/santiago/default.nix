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

        font = null;
        splashImage = null;
        theme = null;

        copyKernels = true;

        enableCryptodisk = true;
        configurationLimit = 10;

        extraConfig = ''
          terminal_input console
          terminal_output console
        '';
      };
    };

    kernelModules = [ "thinkpad_acpi" ];

    kernelParams = [ "i915.enable_psr=0" ];

    extraModprobeConfig = ''
      options thinkpad_acpi force_load=1 fan_control=1
    '';
  };

  home-manager.users.peteyjoe = {
    wayland.windowManager.wayfire.settings = {
      "output:eDP-1" = {
        mode = "1920x1080@60020";
        position = "0,0";
        transform = "normal";
        scale = 1.0;
      };
    };
  };

  system.stateVersion = "26.05";
}
