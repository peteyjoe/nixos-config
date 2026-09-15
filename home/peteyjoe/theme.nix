{ pkgs, ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
