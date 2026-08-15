{ ... }:

{
  imports = [
    ./disko.nix
    ./networking.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
  };

  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKSoyzrAENRjP8H3MFeIm2IYU8Z0cyim7r1LJxRZVBm peteyjoe@big-juan"
  ];

  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "26.05";
}
