{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      custom = "${config.xdg.configHome}/zsh-theme";
      theme = "custom";
      plugins = [
        "git"
        "z"
        "vi-mode"
        "history-substring-search"
      ];
    };

    shellAliases = {
      ll  = "ls -lah";
      gst = "git status";
      pms = "python manage.py runserver";
      pmm = "python manage.py migrate";
      pmc = "python manage.py collectstatic";
      pma = "python manage.py makemigrations";
      pmu = "python manage.py createsuperuser";
    };

    initContent = ''
    # function to launch your tmux session picker
    function session_switcher() {
      ~/.config/session.sh
      zle redisplay
    }

    # we can't bind immediately; defer until ZLE is active
    autoload -Uz add-zsh-hook
    add-zsh-hook -Uz zle-line-init () {
      zle -N session_switcher
      bindkey '^F' session_switcher
    }    

	HISTFILE=$HOME/.local/share/zsh/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.stateVersion = "24.05";
}
