{
  pkgs,
  userVars,
  config,
  ...
}: {
  programs = {
    git = {
      enable = true;
      userName = userVars.gitUsername;
      userEmail = userVars.email;
      signing = {
        key = "${config.home.homeDirectory}/.ssh/github.pub";
        signByDefault = true;
      };
      aliases = {
        a = "add";
        br = "branch";
        bl = "blame";
        c = "commit";
        ca = "commit -a";
        cm = "commit --amend";
        cmn = "commit --amend --no-edit";
        cl = "clone";
        co = "checkout";
        d = "diff";
        f = "fetch";
        i = "init";
        l = "log --graph --oneline --decorate";
        m = "merge";
        pl = "pull";
        ps = "push -u";
        rb = "rebase";
        rv = "revert";
        st = "status";
        sw = "switch";
      };
      extraConfig = {
        merge.conflictstyle = "diff3";
        blame.pager = "${pkgs.delta}/bin/delta";
        diff.colorMoved = "default";
        init.defaultBranch = "main";
        gpg.format = "ssh";
      };
      delta = {
        enable = true;
        options = {
          line-numbers = true;
          side-by-side = true;
          navigate = true;
          true-color = "always";
        };
      };
    };

    git-credential-oauth.enable = true;
  };
}
