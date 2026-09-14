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

  powerManagement.cpuFreqGovernor = "performance";

  services.power-profiles-daemon.enable = true;
  services.tlp.enable = false;
  services.auto-cpufreq.enable = false;

  boot.kernelParams = [
    "pcie_aspm.policy=performance"
    "usbcore.autosuspend=-1"
  ];

  home-manager.users.peteyjoe = {
    wayland.windowManager.wayfire.settings = {
      "output:DP-1" = {
        mode = "1920x1080@74.973";
        position = "0,0";
        transform = "90";
        scale = 1.0;
      };

      "output:DP-2" = {
        mode = "2560x1440@240.001007";
        position = "1080,240";
        transform = "normal";
        scale = 1.0;
      };

      "output:HDMI-A-1" = {
        mode = "1920x1080@60";
        position = "3640,0";
        transform = "270";
        scale = 1.0;
      };
    };
  };

  system.stateVersion = "26.05";
}
