{
  pkgs,
  userVars,
  config,
  ...
}: {
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = userVars.gitUsername;
          inherit (userVars) email;
          signingKey = "${config.home.homeDirectory}/.ssh/github.pub";
        };
        alias = {
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
        blame.pager = "${pkgs.delta}/bin/delta";
        commit.gpgSign = true;
        core.pager = "${pkgs.delta}/bin/delta";
        diff.colorMoved = "default";
        gpg = {
          format = "ssh";
          inherit (config.programs.git.settings.user) signingKey;
        };
        init.defaultBranch = "main";
        interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
        merge.conflictstyle = "diff3";
        signing = {
          key = config.programs.git.settings.user.signingKey;
          signByDefault = true;
        };
        safe.directory = "/etc/nixos";
      };
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

    git-credential-oauth.enable = true;
  };
}
