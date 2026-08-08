{ ... }:

{
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";

    fileSystems = [
      "/"
      "/srv/apps/appdata"
      "/srv/vault/files"
    ];
  };

  services.smartd = {
    enable = true;
    autodetect = true;
  };
}
