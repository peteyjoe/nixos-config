{ config, ... }:

let
  ddnsConfig = {
    settings = [
      {
        provider = "cloudflare";
        zone_identifier = "4d879e004a0a98c9b2ff2305e17980f3";
        domain = "thisismy.casa";
        ttl = 1;
        token = config.sops.placeholder.cloudflare-ddns-api-token;
        ip_version = "ipv4";
        proxied = true;
      }

      /* {
        provider = "cloudflare";
        zone_identifier = "4d879e004a0a98c9b2ff2305e17980f3";
        domain = "thisismy.casa";
        ttl = 1;
        token = config.sops.placeholder.cloudflare-ddns-api-token;
        ip_version = "ipv6";
        ipv6_suffix = "::1108/64";
        proxied = true;
      } */
    ];
  };
in
{
  sops.secrets.cloudflare-ddns-api-token = {
    sopsFile = ../../secrets/the-box.yaml;
  };

  sops.templates."ddns-updater.env" = {
    content = ''
      CONFIG='${builtins.toJSON ddnsConfig}'
    '';
  };

  services.ddns-updater = {
    enable = true;

    environment = {
      PERIOD = "5m";
      RESOLVER_ADDRESS = "1.1.1.1:53";
      SERVER_ENABLED = "no";
    };
  };

  systemd.services.ddns-updater.serviceConfig.EnvironmentFile =
    config.sops.templates."ddns-updater.env".path;
}
