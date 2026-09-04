{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./networking.nix

    ../../modules/shared/base.nix
    ../../modules/shared/desktop-packages.nix
    ../../modules/shared/steam.nix
  ];

  nixpkgs-unstable.config.allowUnfree = true;

  users.users.peteyjoe = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  programs.wayfire = {
    enable = true;

    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };

  services.greetd = {
    enable = true;
    useTextGreeter = true;

    settings.default_session = {
      command =
        "${pkgs.tuigreet}/bin/tuigreet"
        + " --time"
        + " --remember"
        + " --remember-user-session"
        + " --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";

      user = "greeter";
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
