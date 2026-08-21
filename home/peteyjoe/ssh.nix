{ ... }:

{
  programs.ssh = {
    enable = true;

    settings."github.com" = {
      HostName = "github.com";
      User = "git";

      IdentityFile = "~/.ssh/id_ed25519";
      IdentitiesOnly = true;
    };
  };

  services.ssh-agent.enable = true;
}

