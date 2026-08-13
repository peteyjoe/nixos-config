{ ... }:

{
  systemd.tmpfiles.rules = [
    "d /srv/apps/appdata/microbin 0755 root root -"
  ];

  fileSystems."/var/lib/microbin" = {
    device = "/srv/apps/appdata/microbin";
    fsType = "none";
    options = [
      "bind"
      "nofail"
      "x-systemd.requires-mounts-for=/srv/apps/appdata"
    ];
  };

  services.microbin = {
    enable = true;

    settings = {
      MICROBIN_BIND = "127.0.0.1";
      MICROBIN_PORT = 23777;

      MICROBIN_PUBLIC_PATH = "https://paste.thisismy.casa";

      MICROBIN_HIGHLIGHTSYNTAX = true;
      MICROBIN_PRIVATE = true;

      MICROBIN_DISABLE_TELEMETRY = true;
      MICROBIN_LIST_SERVER = false;
    };
  };

  services.caddy.virtualHosts."paste.thisismy.casa".extraConfig = ''
    reverse_proxy 127.0.0.1:23777
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
