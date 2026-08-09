{ ... }:

{
  services.monero = {
    enable = true;

    dataDir = "/srv/apps/monero";

    # Keep the complete blockchain.
    prune = false;

    # Don't expose administrative RPC publicly.
    rpc = {
      address = "127.0.0.1";
      port = 18081;
    };

    extraConfig = ''
      # Listen for normal Monero P2P connections.
      p2p-bind-ip=0.0.0.0
      p2p-bind-port=18080

      # Don't try to configure the router with UPnP.
      no-igd=1

      # Useful upstream protection.
      enable-dns-blocklist=1

      # Minimal logging.
      log-level=0
    '';
  };

  systemd.tmpfiles.rules = [
    "d /srv/apps/monero 0700 monero monero -"
  ];

  networking.firewall.allowedTCPPorts = [
    18080
  ];
}
