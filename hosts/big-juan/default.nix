{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  boot = {
    initrd.systemd.enable = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

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

  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    curl
    wget
    fastfetch
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";

}
