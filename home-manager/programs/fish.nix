{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      tat = "tmux a -t $argv";
    };
    interactiveShellInit = ''
      if [ "$GPG_TTY" != (tty | string collect; or echo) ]
        set GPG_TTY (tty | string collect; or echo)
        set -gx GPG_TTY $GPG_TTY
        gpg-connect-agent updatestartuptty /bye >/dev/null
      end

      set -gx LESS '-MRq -z-2 -j2'
      set -gx FZF_DEFAULT_COMMAND 'fd -t f -H -I'
      set -gx PNPM_HOME '/home/poyehchen/.local/share/pnpm'
      set -gx PYTHON_KEYRING_BACKEND 'keyring.backends.null.Keyring'

      set -gx PATH $HOME/bin $HOME/.cargo/bin $HOME/.local/bin $PATH
    '';
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "51b0f37307c7bcfa38089c2eddaad0bbb2e20c64"; # 5.6.0;
          sha256 = "cCI1FDpvajt1vVPUd/WvsjX/6BJm6X1yFPjqohmo1rI=";
        };
      }
    ];
  };
  home.file.".config/fish/themes/Catppuccin Mocha.theme".text = ''
    # name: 'Catppuccin mocha'
    # url: 'https://github.com/catppuccin/fish'
    # preferred_background: 1e1e2e

    fish_color_normal cdd6f4
    fish_color_command 89b4fa
    fish_color_param f2cdcd
    fish_color_keyword f38ba8
    fish_color_quote a6e3a1
    fish_color_redirection f5c2e7
    fish_color_end fab387
    fish_color_comment 7f849c
    fish_color_error f38ba8
    fish_color_gray 6c7086
    fish_color_selection --background=313244
    fish_color_search_match --background=313244
    fish_color_option a6e3a1
    fish_color_operator f5c2e7
    fish_color_escape eba0ac
    fish_color_autosuggestion 6c7086
    fish_color_cancel f38ba8
    fish_color_cwd f9e2af
    fish_color_user 94e2d5
    fish_color_host 89b4fa
    fish_color_host_remote a6e3a1
    fish_color_status f38ba8
    fish_pager_color_progress 6c7086
    fish_pager_color_prefix f5c2e7
    fish_pager_color_completion cdd6f4
    fish_pager_color_description 6c7086
  '';
}
