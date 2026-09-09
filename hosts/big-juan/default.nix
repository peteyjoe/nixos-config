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

  system.stateVersion = "26.05";

}
