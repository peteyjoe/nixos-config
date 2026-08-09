{ config, ... }:

{
  sops.secrets.vaultwarden-admin-token = {
    sopsFile = ../../secrets/the-box.yaml;
  };

  sops.templates."vaultwarden.env" = {
    content = ''
      ADMIN_TOKEN=${config.sops.placeholder.vaultwarden-admin-token}
    '';
    owner = "vaultwarden";
  };

  services.vaultwarden = {
    enable = true;

    environmentFile =
      config.sops.templates."vaultwarden.env".path;

    config = {
      DOMAIN = "https://vault.thisismy.casa";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      SIGNUPS_ALLOWED = true;
    };
  };

  services.caddy.virtualHosts."vault.thisismy.casa".extraConfig = ''
    reverse_proxy 127.0.0.1:8222
  '';
}
