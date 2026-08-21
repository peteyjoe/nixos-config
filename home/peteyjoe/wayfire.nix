{ pkgs, ... }:

{
  wayland.windowManager.wayfire = {
    enable = true;

    package = null; # Wayfire is installed system-wide

    wf-shell.enable = true;
    xwayland.enable = true;

    settings = {
      "output:DP-1" = {
        mode = "1920x1080@74.973";
        position = "0,0";
        transform = "90";
        scale = 1.0;
      };

      "output:DP-2" = {
        mode = "2560x1440@240.001007";
        position = "1080,240";
        transform = "normal";
        scale = 1.0;
      };

      "output:HDMI-A-1" = {
        mode = "1920x1080@60";
        position = "3640,0";
        transform = "270";
        scale = 1.0;
      };

      core = {
        plugins = builtins.concatStringsSep " " [
          "alpha"
          "animate"
          "command"
          "cube"
          "decoration"
          "expo"
          "fast-switcher"
          "fisheye"
          "foreign-toplevel"
          "grid"
          "gtk-shell"
          "idle"
          "invert"
          "move"
          "oswitch"
          "place"
          "resize"
          "session-lock"
          "shortcuts-inhibit"
          "switcher"
          "vswitch"
          "window-rules"
          "wm-actions"
          "wobbly"
          "wrot"
          "zoom"
        ];

        close_top_view = "<super> KEY_Q | <alt> KEY_F4";

        vwidth = 3;
        vheight = 3;
      };

      command = {
        binding_terminal = "<super> KEY_ENTER";
        command_terminal = "${pkgs.ghostty}/bin/ghostty";

        binding_launcher = "<super> KEY_D";
        command_launcher = "${pkgs.fuzzel}/bin/fuzzel";
      };

      move.activate = "<super> BTN_LEFT";
      resize.activate = "<super> BTN_RIGHT";
    };
  };
}
