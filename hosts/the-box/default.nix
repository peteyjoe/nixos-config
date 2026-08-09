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

      ../../modules/services/caddy.nix
      ../../modules/services/ddns-updater.nix
      ../../modules/services/i2pd.nix
      ../../modules/services/monero.nix
      ../../modules/services/ssh.nix
      ../../modules/services/samba.nix
      ../../modules/services/vaultwarden.nix
      ../../modules/services/wireguard.nix
    ];

  networking.hostName = "the-box";

  system.stateVersion = "26.05";

}
