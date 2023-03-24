{ config, pkgs, ... }: {
  home.packages = with pkgs.fishPlugins; [ foreign-env autopair-fish ];
  programs.fish = {
    enable = true;
    plugins = [{
      name = "fzf";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "fzf";
        rev = "main";
        sha256 = "28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
      };
    }
    # {
    #   name = "catppuccin";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "catppuccin";
    #     repo = "fish";
    #     rev = "b90966686068b5ebc9f80e5b90fdf8c02ee7a0ba";
    #     sha256 = "";
    #   };
    # }
      ];
    shellInit = builtins.readFile config/fish/init.fish;
    shellAliases = {
      # docker
      d = "docker";
      dc = "docker-compose";

      # git
      g = "git";
      gl = "git pull --prune";
      glg = "git log --graph --decorate --oneline --abbrev-commit";
      glga = "glg --all";
      gp = "git push origin HEAD";
      gpa = "git push origin --all";
      gd = "git diff";
      gc = "git commit -s";
      gca = "git commit -sa";
      gco = "git checkout";
      gb = "git branch -v";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit -sm";
      gcam = "git commit -sam";
      gs = "git status -sb";
      glnext = "git log --oneline (git describe --tags --abbrev=0 @^)..@";
      gw = "git switch";
      gm = "git switch (git main-branch)";
      gms = "git switch (git main-branch); and git sync";
      egms = "e; git switch (git main-branch); and git sync";
      gwc = "git switch -c";

      # go
      gmt = "go mod tidy";
      grm = "go run ./...";

      # kubectl
      kx = "kubectx";
      kn = "kubens";
      k = "kubectl";
      sk = "kubectl -n kube-system";
      kg = "kubectl get";
      kgp = "kubectl get po";
      kga = "kubectl get --all-namespaces";
      kd = "kubectl describe";
      kdp = "kubectl describe po";
      krm = "kubectl delete";
      ke = "kubectl edit";
      kex = "kubectl exec -it";
      kdebug = ''
        kubectl run -i -t debug --rm --image=caarlos0/debug --restart=Never
      '';
      knrunning = "kubectl get pods --field-selector=status.phase!=Running";
      kfails = ''
        kubectl get po -owide --all-namespaces | grep "0/" | tee /dev/tty | wc -l
      '';
      kimg = ''
        kubectl get deployment --output=jsonpath='{.spec.template.spec.containers[*].image}'
      '';
      kvs = "kubectl view-secret";
      kgno = "kubectl get no --sort-by=.metadata.creationTimestamp";
      kdrain = "kubectl drain --ignore-daemonsets --delete-local-data";

      # neovim
      e = "nvim";
      v = "nvim";
      vim = "nvim";

      # terraform
      tf = "terraform";

      # tmux
      ta = "tmux-new";
    };
  };

  xdg.configFile."fish/functions/c.fish" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/c.fish;
  };

  xdg.configFile."fish/functions/cdr.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/cdr.fish;
  };

  xdg.configFile."fish/functions/certp.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/cerpt.fish;
  };

  xdg.configFile."fish/functions/docker-cp.fish" = {
    source = config.lib.file.mkOutOfStoreSymlink
      ./config/fish/functions/docker-cp.fish;
  };

  xdg.configFile."fish/functions/gotestcovpkgs.fish" = {
    source = config.lib.file.mkOutOfStoreSymlink
      ./config/fish/functions/gotestcovpkgs.fish;
  };

  xdg.configFile."fish/functions/gpr.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/gpr.fish;
  };

  xdg.configFile."fish/functions/gtn.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/gtn.fish;
  };

  xdg.configFile."fish/functions/gwf.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/gwf.fish;
  };

  xdg.configFile."fish/functions/h.fish" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/h.fish;
  };

  xdg.configFile."fish/functions/mkc.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/mkc.fish;
  };

  xdg.configFile."fish/functions/myip.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/myip.fish;
  };

  xdg.configFile."fish/functions/ports.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/ports.fish;
  };

  xdg.configFile."fish/functions/pubkey.fish" = {
    source =
      config.lib.file.mkOutOfStoreSymlink ./config/fish/functions/pubkey.fish;
  };

  imports = [ ./starship.nix ./exa.nix ./bat.nix ./zoxide.nix ];
}
