{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    defaultEditor = true;

    mutableUserSettings = false;
    mutableUserKeymaps = false;

    extraPackages = with pkgs; [
      nixd
      nixfmt
      nil
    ];

    extensions = [
      "nix"
    ];

    userSettings = {
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };

      ui_font_size = 16;
      buffer_font_size = 15;

      format_on_save = "on";

      semantic_tokens = "combined";

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      edit_predictions = {
        provider = "none";
      };
    };
  };
}
