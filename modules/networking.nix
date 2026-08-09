{ ... }:

{
  networking.networkmanager = {
    enable = true;
    
    ensureProfiles.profiles = {
      lan = {
        connection = {
          id = "lan";
          type = "ethernet";
          interface-name = "eno1";
          autoconnect = true;
        };

        ipv4 = {
          method = "auto";
        };

        ipv6 = {
          method = "auto";
          address1 = "fd69:dead:beef:1::10/64";
        };
      };
    };
  };
}
