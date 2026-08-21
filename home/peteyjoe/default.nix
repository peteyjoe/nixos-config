{ pkgs, ... }:

{
  imports = [
    ./brave.nix
    ./ghostty.nix
    ./git.nix
    ./ssh.nix
    ./theme.nix
    ./wayfire.nix
  ];

  home.username = "peteyjoe";
  home.homeDirectory = "/home/peteyjoe";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fuzzel
    mako
    wl-clipboard
    grim
    slurp
    pavucontrol
    playerctl
    brightnessctl
    networkmanagerapplet
    thunar
    ripgrep
    fd
    jq
  ];

  programs.git.enable = true;
}
