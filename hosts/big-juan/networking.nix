{ ... }:

{
  networking = {
    hostName = "big-juan";

    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };
}
