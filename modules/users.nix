{ ... }:

{
  users.users.peteyjoe = {
    isNormalUser = true;
    description = "Peter";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKSoyzrAENRjP8H3MFeIm2IYU8Z0cyim7r1LJxRZVBm peteyjoe@big-juan"
    ]
  };
}
