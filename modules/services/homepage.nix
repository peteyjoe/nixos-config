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
      listenPort = 35196;

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
            style = "row";
            columns = 3;
          };

          Network = {
            style = "row";
            columns = 3;
          };
        };
      };

      widgets = [
        {
          glances = {
            url = "http://127.0.0.1:61208";
            version = 4;
            cpu = true;
            mem = true;
            cputemp = true;
            uptime = true;
            expanded = true;
          };
        }
      ];
    };

    services.caddy.virtualHosts."home.thisismy.casa".extraConfig = ''
      reverse_proxy 127.0.0.1:35196
    '';
  };
}
