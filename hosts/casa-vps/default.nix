{ ... }:

{
  imports = [
    ./disko.nix
    ./networking.nix
    ./hardware-configuration.nix

    ../../modules/base.nix
    ../../modules/users.nix
    ../../modules/sops.nix

    ../../modules/services/ssh.nix
  ];

  system.stateVersion = "26.05";
}
