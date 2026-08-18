{ ... }:

{
  networking.networkmanager.enable = false;

  networking.useNetworkd = true;

  systemd.network = {
    enable = true;

    config.networkConfig = {
      IPv4Forwarding = true;
    };

    networks."10-lan" = {
      matchConfig.Name = "eno1";

      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
      };

      ipv6AcceptRAConfig = {
        Token = "::1108";
      };

      addresses = [
        {
          Address = "fd69:dead:beef:2::10/64";
        }
      ];
    };
  };
}
