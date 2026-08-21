{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Peter";
        email = "git@peteyjoe.com";
      };

      init.defaultBranch = "master";

      pull.rebase = false;
    };
  };
}

