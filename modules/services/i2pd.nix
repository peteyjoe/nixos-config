{ ... }:

{
  services.i2pd = {
    enable = true;

    enableIPv4 = true;
    enableIPv6 = false;

    port = 31337;
    nat = true;
    notransit = false;
    floodfill = true;
    bandwidth = 1024; # KiB/s
    share = 80; # %

    addressbook.subscriptions = [
      "http://inr.i2p/export/alive-hosts.txt"
      "http://i2p-projekt.i2p/hosts.txt"
      "http://stats.i2p/cgi-bin/newhosts.txt"
      "http://reg.i2p/export/hosts.txt"
    ];

    ntcp2 = {
      enable = true;
      published = true;
      port = 31337;
    };

    ssu2 = {
      enable = true;
      published = true;
      port = 31337;
    };

    proto = {
      http = {
        enable = true;
        address = "127.0.0.1";
        port = 7070;
        hostname = "i2pd.thisismy.casa";
        strictHeaders = true;
      };

      httpProxy = {
        enable = true;
        address = "0.0.0.0";
        port = 4444;
      };

      socksProxy.enable = false;
    };
  };

  networking.firewall.allowedTCPPorts = [
    4444
    31337
  ];

  networking.firewall.allowedUDPPorts = [
    31337
  ];

  services.caddy.virtualHosts."i2pd.thisismy.casa".extraConfig = ''
    reverse_proxy 127.0.0.1:7070
  '';

  systemd.services.i2pd.serviceConfig.LimitNOFILE = "65536:524288";
}
