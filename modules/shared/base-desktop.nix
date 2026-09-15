{ config, pkgs, ... }:

{
  users.users.peteyjoe = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "vboxusers"
    ];
  };

  virtualisation.virtualbox.host.enable = true;

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

  xdg.icons.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
