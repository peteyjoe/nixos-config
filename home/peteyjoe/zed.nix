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
      jdk21
      ruby
    ];

    extensions = [
      "nix"
      "java"
      "html"
      "toml"
      "ruby"
      "dockerfile"
      "git-firefly"
      "catppuccin"
      "catppuccin-icons"
    ];

    userSettings = {
      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };

      icon_theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
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

      agent_servers = {
        codex-acp = {
          type = "registry";
        };
      };
    };
  };
}
