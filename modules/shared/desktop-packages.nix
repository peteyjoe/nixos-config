{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    htop
    curl
    wget
    btrfs-progs
    smartmontools
    parted
    bandwhich
    fastfetch
  ];
}
