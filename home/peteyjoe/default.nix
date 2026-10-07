{ pkgs, ... }:

{
  imports = [
    ./brave.nix
    ./ghostty.nix
    ./git.nix
    ./librewolf.nix
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
    ripgrep
    fd
    jq
    wineWow64Packages.stagingFull
    winetricks
    texstudio
    texliveFull

    # Polkit agent
    mate-polkit

    # Archive manager
    engrampa

    # Archive format support
    _7zz
    unrar
    zip
    unzip
    gzip
    bzip2
    xz
    zstd
    brotli
    lzip
    lzop
    lrzip
    cpio
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
