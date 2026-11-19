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

      defaultProvider = "openai";
      defaultModel = "gpt-6.2-sol";
      defaultThinkingLevel = "high";
    };
    # Global user instructions, written to ${pi.configDir}/AGENTS.md.
    context = ''
      # Global Instructions

      ## Tools and packages: use Nix, keep the system clean

      This machine runs NixOS. Do not install anything into the user or system environment.

      - If the project has a `flake.nix` with a dev shell, run commands inside it:
        `nix develop -c <command>` (or `nix develop .#<shell> -c <command>`).
      - For tools the dev shell doesn't provide, or projects without a flake, use an
        ephemeral shell: `nix shell nixpkgs#<pkg> [nixpkgs#<pkg2> ...] -c <command>`.
        To find the right attribute, use `nix search nixpkgs <name>`.
      - Never use `nix-env -i`, `nix profile install`, `sudo`, or any global or user-level
        installer (`pip install --user`, `npm install -g`, `cargo install`, `go install`,
        `curl ... | sh`, etc.).
      - Never edit NixOS or Home Manager configuration just to get a tool for a task.
      - Project-local dependency installs (e.g. `npm install` into `node_modules`, a venv
        inside the project) are fine when the project expects them, but run them from
        inside `nix develop` or `nix shell` so the toolchain comes from Nix.
      - If a tool isn't available through Nix, stop and ask me instead of working around it.

      ## Git: no history, branch, or remote changes unless I ask

      - Allowed without asking:
        - Read-only commands such as `git status`, `git diff`, `git log`, `git show`,
          `git blame`, `git ls-files`, `git rev-parse`, `git branch` (listing only),
          and `git remote -v`.
        - Staging with `git add` (or `git add -N`), e.g. so a flake can see new files,
          and unstaging with `git restore --staged`.
      - Only when I explicitly ask in the current request:
        - Creating, switching, renaming, or deleting branches (`git branch <name>`,
          `git switch`, `git checkout`, `git worktree add`).
        - Committing, including `--amend`, and anything else that rewrites history
          (`rebase`, `reset`, `merge`, `cherry-pick`, `revert`, `tag`, `stash`).
        - Talking to remotes: `git push`, `git pull`, `git fetch`, `git clone`,
          changing remotes, and `gh` commands that create or modify PRs, issues, or
          releases.
        - Discarding work: `git restore <file>`, `git checkout -- <file>`, `git clean`.
        - Changing git config.
      - Permission for one git action does not extend to others; for example, being
        asked to commit doesn't mean you may push.
      - If one of these would help, say so and ask first.
    '';
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
