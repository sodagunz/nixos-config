{ ... }:
{
  flake.homeModules.git =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.gh ];
      programs = {
        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            diff-so-fancy = true;
            line-numbers = true;
            navigate = true;
            side-by-side = true;
          };
        };
        git = {
          enable = true;
          settings = {
            credential.helper = "store";
            diff.colorMoved = "default";
            init.defaultBranch = "main";
            merge.conflictstyle = "diff3";
            push.autoSetupRemote = true;
            user = {
              email = "sodagunz@proton.me";
              name = "sodagunz";
            };
          };
        };
        zsh.shellAliases = {
          g = "lazygit";
          ga = "git add";
          gaa = "git add --all";
          gb = "git branch";
          gc = "git commit";
          gch = "git checkout";
          gchb = "git checkout -b";
          gcl = "git clone";
          gcm = "git commit -m";
          gcma = "git add --all && git commit -m";
          gd = "git diff";
          gf = "onefetch --number-of-file-churns 0 --no-color-palette";
          glog = "git log --oneline --decorate --graph";
          glol = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
          glola = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all";
          glols = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat";
          gm = "git merge";
          gpl = "git pull";
          gplo = "git pull origin";
          gps = "git push";
          gpso = "git push origin";
          gpst = "git push --follow-tags";
          gs = "git status";
          gtag = "git tag -ma";
        };
      };
    };
}
