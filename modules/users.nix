{ ... }:

{
  users.users.peteyjoe = {
    isNormalUser = true;
    description = "Peter";

    extraGroups = [
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKSoyzrAENRjP8H3MFeIm2IYU8Z0cyim7r1LJxRZVBm peteyjoe@big-juan"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGyqWdX6HLecqAzpzwX/waCMN/4nIkfKCiEreSJucsC peteyjoe@the-box"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFayQe38Wnl4I1qFlkSzXE9LYakwVpER9fBQjdkm1Nsk peteyjoe@santiago"
    ];
  };

  nix.settings.trusted-users = [ "root" "peteyjoe" ];
}
