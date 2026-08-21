{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

    protontricks.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    localNetworkGameTransfers.openFirewall = true;
  };
}
