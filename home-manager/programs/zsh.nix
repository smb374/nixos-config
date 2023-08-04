{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    history = {
      path = "$HOME/.zsh_history";
      save = 10000;
      share = true;
      size = 10000;
    };
    localVariables = {
      LESS = "-MRq -z-2 -j2";
      FZF_DEFAULT_COMMAND = "fd -t f -H -I";
      PNPM_HOME = "/home/poyehchen/.local/share/pnpm";
      PATH = "$HOME/.local/bin:$HOME/.cargo/bin:$HOME/bin:$PATH";
      PYTHON_KEYRING_BACKEND = "keyring.backends.null.Keyring";
    };
    # Init
    initExtraBeforeCompInit = ''
      bindkey "\E[1~" beginning-of-line
      bindkey "\E[4~" end-of-line
      bindkey "\E[H" beginning-of-line
      bindkey "\E[F" end-of-line
      bindkey "\E[3~" delete-char

      fpath+="$HOME/.zfunc"

      if [[ ! -f $HOME/.zcomet/bin/zcomet.zsh ]]; then
        command git clone https://github.com/agkozak/zcomet.git $HOME/.zcomet/bin
      fi

      source $HOME/.zcomet/bin/zcomet.zsh

      zcomet load agkozak/agkozak-zsh-prompt
      zcomet load mafredri/zsh-async
      zcomet load ohmyzsh plugins/gitfast
      zcomet load ohmyzsh plugins/colored-man-pages
      zcomet load zdharma-continuum/fast-syntax-highlighting
      zcomet load zsh-users/zsh-history-substring-search

      zcomet compinit

      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
    '';
    initExtra = ''
      setopt autocd extendedglob

      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
    '';
  };
}
