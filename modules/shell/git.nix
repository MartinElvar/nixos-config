{
  programs = {
    git = {
      # difftastic.enable = true;
      enable = true;
      config = {
        user = {
          name = "Elvar";
          email = "m@martinelvar.dk";
        };
        apply.whitespace = "nowarn";
        color = {
          ui = true;
          diff = "auto";
          status = "auto";
          branch = "auto";
          interactive = "auto";
        };
        core = {
          quotepath = false;
          whitespace = "-blank-at-eol";
          editor = "vim";
          autocrlf = "input";
        };
        mirror.summary = true;
        push = {
          default = "tracking";
          autoSetupRemote = true;
        };
        alias = {
          nb = "switch -c";
          co = "checkout";
          lc = "log @{1}.. --stat --no-merges";
          lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --date=relative --date-order --all --decorate";
          l = "log --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset'  --date=relative --date-order --all --decorate";
          ll = "log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset' --decorate --numstat";
          stat = "log --pretty=tformat:'%n%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%an %cr)%Creset'  --date=relative --date-order --stat --all --decorate";
          oneline = "log --pretty=oneline --all --decorate";
          ff = "merge --ff-only @{u}";
          a  = "add";
          st = "status";
          s  = "status -s";
          ci = "commit";
          br = "branch -v";
          staged = "diff --cached";
          both = "diff HEAD";
          count = "rev-list HEAD --count";
          up = "pull --rebase --autostash";
        };
      };
    };
  };
}
