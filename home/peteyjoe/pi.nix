{
  config,
  lib,
  pkgs,
  ...
}:

let
  pi = config.programs.pi-coding-agent;
  piExtensionExamples = "${pi.package}/lib/node_modules/pi-monorepo/examples/extensions";
  piAcp = pkgs.buildNpmPackage (finalAttrs: {
    pname = "pi-acp";
    version = "0.0.34";

    src = pkgs.fetchurl {
      name = "pi-acp-${finalAttrs.version}.tar.gz";
      url = "https://codeload.github.com/svkozak/pi-acp/tar.gz/refs/tags/v${finalAttrs.version}";
      hash = "sha256-9nu35qp0yN3VzycovRFoVdyJGII7hh2ZX3EngkxbVv8=";
    };

    npmDepsHash = "sha256-BvLNtFfp1cMVjzWcMRSdhTqiJrTfbFoUbWkkPW9200o=";
    meta.mainProgram = "pi-acp";
  });
in
{
  programs.pi-coding-agent = {
    enable = true;
    extraPackages = [ pkgs.nodejs ];
    mutableSettings = true;
    settings = {
      packages = [
        "npm:pi-claude-bridge@0.13.0"
        "npm:pi-mcp-adapter@7.0.1"
        "npm:pi-web-access@0.48.0"
        "npm:pi-subagents@0.89.1"
        "npm:@specode/pi-subscription-usage@1.5.0"
      ];
      defaultProjectTrust = "ask";
      quietStartup = "header";
      collapseChangelog = true;
      hideThinkingBlock = true;
      cacheWarming = "streaming";
    };
  };

  programs.zed-editor.userSettings.agent_servers."Pi (Nix)" = {
    type = "custom";
    command = lib.getExe piAcp;
    env = {
      PI_ACP_PI_COMMAND = lib.getExe pi.package;
      PI_CODING_AGENT_DIR = pi.configDir;
    };
  };

  home.file = {
    "${pi.configDir}/claude-bridge.json".text = builtins.toJSON {
      provider.pathToClaudeCodeExecutable = lib.getExe pkgs.claude-code;
    };
    "${pi.configDir}/extensions/bookmark.ts".source = "${piExtensionExamples}/bookmark.ts";
    "${pi.configDir}/extensions/notify.ts".text = ''
      import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
      import notify from "${piExtensionExamples}/notify.ts";

      export default function (pi: ExtensionAPI) {
        // Keep terminal escape sequences out of piped JSON and RPC output.
        if (process.stdout.isTTY) {
          notify(pi);
        }
      }
    '';
  };
}
