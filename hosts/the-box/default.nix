{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/base.nix
      ../../modules/networking.nix
      ../../modules/sops.nix
      ../../modules/storage.nix
      ../../modules/users.nix

      ../../modules/services/ssh.nix
      ../../modules/services/samba.nix
    ];

  networking.hostName = "the-box";

  system.stateVersion = "26.05";

}
