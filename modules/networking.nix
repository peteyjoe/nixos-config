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

      addresses = [
        {
          Address = "fd69:dead:beef:1::10/64";
        }
      ];
    };
  };
}
