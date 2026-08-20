{ pkgs, ... }:

{
  wayland.windowManager.wayfire = {
    enable = true;

    package = null; # Wayfire is installed system-wide

    wf-shell.enable = true;
    xwayland.enable = true;

    settings = {
      core = {
        plugins = ''
          alpha
          animate
          command
          cube
          decoration
          expo
          fast-switcher
          fisheye
          foreign-toplevel
          grid
          gtk-shell
          idle
          invert
          move
          oswitch
          place
          resize
          session-lock
          shortcuts-inhibit
          switcher
          vswitch
          window-rules
          wm-actions
          wobbly
          wrot
          zoom
        '';

        close_top_view = "<super> KEY_Q | <alt> KEY_F4";

        vwidth = 3;
        vheight = 3;
      };

      command = {
        binding_terminal = "<super> KEY_ENTER";
        command_terminal = "ghostty";

        binding_launcher = "<super> KEY_D";
        command_launcher = "fuzzel";
      };

      move.activate = "<super> BTN_LEFT";
      resize.activate = "<super> BTN_RIGHT";
    };
  };
}
