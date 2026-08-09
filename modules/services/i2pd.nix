{ ... }:

{
  services.i2pd = {
    enable = true;

    enableIPv4 = true;
    enableIPv6 = true;

    # Optional: don't dedicate excessive bandwidth initially.
    bandwidth = 4096; # KiB/s

    proto = {
      http = {
        enable = true;
        address = "127.0.0.1";
        port = 7070;
      };

      httpProxy = {
        enable = true;
        address = "0.0.0.0";
        port = 4444;
      };

      socksProxy.enable = false;
    };

    extraConfig = ''
        [http]
        hostname = i2pd.thisismy.casa
        strictheaders = true
      '';
  };

  networking.firewall.allowedTCPPorts = [
    4444
  ];

  services.caddy.virtualHosts."i2pd.thisismy.casa".extraConfig = ''
    reverse_proxy 127.0.0.1:7070
  '';
}
