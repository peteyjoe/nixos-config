{ pkgs, ... }:

{
  imports = [
    ./brave.nix
    ./ghostty.nix
    ./git.nix
    ./ssh.nix
    ./theme.nix
    ./wayfire.nix
    ./zed.nix
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
    sway-contrib.grimshot
    pavucontrol
    playerctl
    brightnessctl
    networkmanagerapplet
    thunar
    ripgrep
    fd
    jq
    wineWow64Packages.stagingFull
    winetricks
    texstudio
    texlive.combined.scheme-full
  ];

  programs.git.enable = true;
  programs.onlyoffice.enable = true;
  programs.bash.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };
}
