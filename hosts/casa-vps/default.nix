{ ... }:

{
  imports = [
    ./disko.nix
    ./networking.nix
    ./hardware-configuration.nix

    ../../modules/base.nix
    ../../modules/users.nix
    ../../modules/services/ssh.nix
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKSoyzrAENRjP8H3MFeIm2IYU8Z0cyim7r1LJxRZVBm peteyjoe@big-juan"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGyqWdX6HLecqAzpzwX/waCMN/4nIkfKCiEreSJucsC peteyjoe@the-box"
  ];

  system.stateVersion = "26.05";
}
