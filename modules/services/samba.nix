{ config, pkgs, ... }:

{
  sops.secrets.samba-password = {
    sopsFile = ../../secrets/the-box.yaml;
  };

  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "the-box";
        "netbios name" = "THE-BOX";
        "security" = "user";
        "map to guest" = "never";
      };

      vault = {
        path = "/srv/vault/files";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";

        "valid users" = "peteyjoe";

        "create mask" = "0664";
        "directory mask" = "0775";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  system.activationScripts.samba-password = {
    deps = [ "setupSecrets" ];

    text = ''
      password="$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.samba-password.path})"

      ${pkgs.coreutils}/bin/printf '%s\n%s\n' \
        "$password" "$password" |
        ${pkgs.samba}/bin/smbpasswd -s -a peteyjoe
    '';
  };
}
