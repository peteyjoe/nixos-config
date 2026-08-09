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

  systemd.network = {
    netdevs."20-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };

      wireguardConfig = {
        PrivateKeyFile =
          config.sops.secrets.wireguard-private-key.path;
        # Public Key: KakSanqE1qK45AQiAtANWXzMzo3uljW1V8LcMcjREUM=

        ListenPort = 51820;
      };

      wireguardPeers = [
        {
          # iPhone
          PublicKey = "d9YqHvg5+mez+hCodeyUKg14eaOZip30ijZTLZXUblI=";
          AllowedIPs = [
            "10.69.69.2/32"
          ];
        }
      ];
    };

    networks."20-wg0" = {
      matchConfig.Name = "wg0";

      networkConfig = {
        IPForward = true;
      };

      address = [
        "10.69.69.1/24"
      ];
    };
  };

  networking.firewall = {
    allowedUDPPorts = [
      51820
    ];

    extraForwardRules = ''
      iifname "wg0" oifname "eno1" accept
      iifname "eno1" oifname "wg0" ct state established,related accept
    '';
  };

}
