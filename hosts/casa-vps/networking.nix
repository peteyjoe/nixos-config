{ ... }:

{
  networking = {
    hostName = "casa-vps";

    useDHCP = false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };

  systemd.network = {
    enable = true;

    networks."10-uplink" = {
      matchConfig.MACAddress = "00:16:3e:a2:2b:93";

      address = [
        "192.3.232.77/25"
        "2607:9d00:2000:a1::4048:1649/64"
      ];

      networkConfig = {
        DHCP = "no";
        IPv6AcceptRA = false;
      };

      routes = [
        # IPv4:
        # default via 192.3.232.1 dev eth0 onlink
        {
          Gateway = "192.3.232.1";
          GatewayOnLink = true;
        }

        # IPv6:
        # 2607:9d00:2000:a1::1 dev eth0
        {
          Destination = "2607:9d00:2000:a1::1/128";
        }

        # IPv6:
        # default via 2607:9d00:2000:a1::1
        {
          Gateway = "2607:9d00:2000:a1::1";
        }
      ];

      linkConfig.RequiredForOnline = "routable";
    };
  };
}
