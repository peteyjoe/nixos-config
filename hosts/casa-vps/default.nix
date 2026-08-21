{ ... }:

{
  imports = [
    ./disko.nix
    ./networking.nix
    ./hardware-configuration.nix

    ../../modules/shared/base.nix
    ../../modules/shared/server-packages.nix
    ../../modules/users.nix
    ../../modules/sops.nix

    ../../modules/services/ssh.nix
  ];

  system.stateVersion = "26.05";
}
