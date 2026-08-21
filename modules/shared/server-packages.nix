{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    btrfs-progs
    smartmontools
    parted
    git
    sops
    age
    htop
    bandwhich
    fastfetch
  ];
}
