{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/base.nix
      ../../modules/networking.nix
      ../../modules/ssh.nix
      ../../modules/storage.nix
      ../../modules/users.nix
    ];

  networking.hostName = "the-box";

  system.stateVersion = "26.05";

}
