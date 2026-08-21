{ ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme =
    "prefer-dark";
}

