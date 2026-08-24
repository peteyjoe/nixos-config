{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  sops.secrets.wireguard-private-key = {
    sopsFile = ../../secrets/the-box.yaml;
    owner = "root";
    group = "systemd-network";
    mode = "0440";
  };

  sops.secrets.wireguard-iphone-psk = {
    sopsFile = ../../secrets/the-box.yaml;
    owner = "root";
    group = "systemd-network";
    mode = "0440";
  };

  sops.secrets.wireguard-laptop-psk = {
    sopsFile = ../../secrets/the-box.yaml;
    owner = "root";
    group = "systemd-network";
    mode = "0440";
  };

  systemd.network = {
    netdevs."20-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };

      wireguardConfig = {
        PrivateKeyFile = config.sops.secrets.wireguard-private-key.path;
        # Public Key: KakSanqE1qK45AQiAtANWXzMzo3uljW1V8LcMcjREUM=

        ListenPort = 30164;
      };

      wireguardPeers = [
        {
          # iPhone
          PublicKey = "d9YqHvg5+mez+hCodeyUKg14eaOZip30ijZTLZXUblI=";
          PresharedKeyFile = config.sops.secrets.wireguard-iphone-psk.path;
          AllowedIPs = [ "10.69.69.2/32" ];
        }

        {
          # Laptop
          PublicKey = "xMu79HEkBAt9xxDhwNM3W5jf/apwwKyhPVTnZy3v9Tk=";
          PresharedKeyFile = config.sops.secrets.wireguard-laptop-psk.path;
          AllowedIPs = [ "10.69.69.3/32" ];
        }
      ];
    };

    networks."20-wg0" = {
      matchConfig.Name = "wg0";

      address = [
        "10.69.69.1/24"
      ];
    };
  };

  networking.firewall = {
    allowedUDPPorts = [
      30164
    ];

    extraForwardRules = ''
      iifname "wg0" oifname "eno1" accept
      iifname "eno1" oifname "wg0" ct state established,related accept
    '';
  };

}
