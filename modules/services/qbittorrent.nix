{ config, pkgs, ... }:

let
  localOnlyProxy = import ../lib/caddy-local-only.nix;

  torrentPort = 11080;
  webUiPort = 8090;

  # Store application configuration on apps SSD.
  configDir = "/srv/apps/appdata/qbittorrent";

  # Store torrents on the vault HDD array.
  filesDir = "/srv/vault/files/torrents";

  # Use the VPN-side DNS resolver from qBittorrent.
  torrentResolvConf = pkgs.writeText "torrent-resolv.conf" ''
    nameserver 127.0.0.1
  '';
in
{
  boot.kernelModules = [ "tun" ];

  sops.secrets.the-box-airvpn-private-key = {
    sopsFile = ../../secrets/the-box.yaml;
    owner = "root";
    group = "systemd-network";
    mode = "0440";
  };
  sops.secrets.the-box-airvpn-psk = {
    sopsFile = ../../secrets/the-box.yaml;
    owner = "root";
    group = "systemd-network";
    mode = "0440";
  };

  sops.templates."airvpn-gluetun.env".content = ''
    WIREGUARD_PRIVATE_KEY=${config.sops.placeholder.the-box-airvpn-private-key}
    WIREGUARD_PRESHARED_KEY=${config.sops.placeholder.the-box-airvpn-psk}
  '';

  virtualisation.oci-containers = {
    backend = "podman";

    containers = {
      gluetun = {
        image = "docker.io/qmcgaw/gluetun:latest";

        capabilities.NET_ADMIN = true;
        devices = [ "/dev/net/tun:/dev/net/tun" ];

        # Wait for the container health check.
        podman.sdnotify = "healthy";

        environment = {
          VPN_SERVICE_PROVIDER = "airvpn";
          VPN_TYPE = "wireguard";

          # Replace with the IPv4 tunnel address from AirVPN.
          WIREGUARD_ADDRESSES = "10.136.124.127/32";

          TZ = "America/Phoenix";

          # Incoming torrent connections via AirVPN.
          FIREWALL_VPN_INPUT_PORTS = toString torrentPort;

          # Permit access to qBittorrent's Web UI.
          FIREWALL_INPUT_PORTS = toString webUiPort;

          SERVER_CITIES = "Phoenix Arizona";
        };

        environmentFiles = [
          config.sops.templates."airvpn-gluetun.env".path
        ];

        # Publish only the Web UI, on localhost.
        ports = [
          "127.0.0.1:${toString webUiPort}:${toString webUiPort}/tcp"
        ];

        extraOptions = [
          "--health-cmd=/gluetun-entrypoint healthcheck"
          "--health-interval=5s"
          "--health-timeout=5s"
          "--health-start-period=10s"
          "--health-retries=3"
        ];
      };

      qbittorrent = {
        image = "lscr.io/linuxserver/qbittorrent:5.2.4";

        dependsOn = [ "gluetun" ];

        environment = {
          PUID = "1000";
          PGID = "100";
          TZ = "America/Phoenix";

          WEBUI_PORT = toString webUiPort;
          TORRENTING_PORT = toString torrentPort;
        };

        volumes = [
          "${configDir}:/config"
          "${filesDir}:/files"
          "${torrentResolvConf}:/etc/resolv.conf:ro"
        ];

        # Share Gluetun's network namespace.
        # Do NOT use host networking here.
        extraOptions = [
          "--network=container:gluetun"
        ];
      };
    };
  };

  # Propagate explicit VPN unit restarts/stops to qBittorrent.
  systemd.services.podman-qbittorrent = {
    partOf = [ "podman-gluetun.service" ];

    unitConfig.RequiresMountsFor = "${configDir} ${filesDir}";
  };

  services.caddy.virtualHosts."qbittorrent.thisismy.casa".extraConfig = localOnlyProxy {
    upstream = "127.0.0.1:${toString webUiPort}";
  };
}
