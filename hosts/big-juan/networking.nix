{ ... }:

{
  networking = {
    hostName = "big-juan";

    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=1
  '';
}
