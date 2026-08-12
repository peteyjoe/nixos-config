{ ... }:

{
  services.microbin = {
    enable = true;

    dataDir = "/srv/apps/appdata/microbin";

    settings = {
      MICROBIN_BIND = "127.0.0.1";
      MICROBIN_PORT = 49061;
      MICROBIN_DATA_DIR = ".";

      MICROBIN_PUBLIC_PATH = "https://paste.thisismy.casa";

      MICROBIN_HIGHLIGHTSYNTAX = true;
      MICROBIN_PRIVATE = true;

      MICROBIN_DISABLE_TELEMETRY = true;
      MICROBIN_LIST_SERVER = false;
    };
  };

  services.caddy.virtualHosts."paste.thisismy.casa".extraConfig = ''
    reverse_proxy 127.0.0.1:49061
  '';

  my.homepage.services.Services = [
    {
      MicroBin = {
        icon = "microbin.png";
        href = "https://paste.thisismy.casa";
        description = "Paste bin";
        siteMonitor = "https://paste.thisismy.casa";
      };
    }
  ];
}
