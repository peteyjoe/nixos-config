{ config, lib, ... }:

let
  cfg = config.my.homepage;
in
{
  options.my.homepage.services = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.attrs);
    default = { };
    description = "Homepage cards grouped by section.";
  };

  config = {
    services.homepage-dashboard = {
      enable = true;

      allowedHosts = "home.thisismy.casa";
      listenPort = 6995;

      services =
        lib.mapAttrsToList
          (group: cards: {
            ${group} = cards;
          })
          cfg.services;

      settings = {
        title = "the-box";
        headerStyle = "clean";
        statusStyle = "dot";

        layout = {
          Services = {
            header = true;
            style = "column";
          };

          Network = {
            header = true;
            style = "column";
          };
        };
      };

      widgets = [
        {
          glances = {
            url = "http://127.0.0.1:29606";
            version = 4;

            cpu = true;
            mem = true;
            cputemp = true;
            uptime = true;

            disk = [
              "/"
              "/srv/apps"
              "/srv/vault"
            ];

            expanded = true;
          };
        }

        {
          datetime = {
            text_size = "xl";

            format = {
              dateStyle = "long";
              timeStyle = "short";
              hour12 = true;
            };
          };
        }
      ];
    };

    my.homepage.services.Network = [
      {
        Router = {
          icon = "router.png";
          href = "http://192.168.0.1";
          description = "FreshTomato";
          ping = "192.168.0.1";
        };
      }
    ];

    services.caddy.virtualHosts."home.thisismy.casa".extraConfig = ''
      reverse_proxy 127.0.0.1:6995
    '';
  };
}
