{ pkgs, ... }:

{
  wayland.windowManager.wayfire = {
    enable = true;

    package = null; # Wayfire is installed system-wide

    wf-shell.enable = true;
    xwayland.enable = true;

  };
}
