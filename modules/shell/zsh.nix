{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true; # Auto suggest options and highlights syntax, searches in history for options
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      ohMyZsh = {
        # Extra plugins for zsh
        enable = true;
        plugins = [ "git" ];
      };

      interactiveShellInit = ''
        # Only run terminal-dependent init when a real tty is attached.
        # Tools like `expert` (Elixir LSP) spawn `$SHELL -i` with piped stdio;
        # fzf/spaceship/pfetch would otherwise error (zle) or pollute the pipe.
        if [[ -t 1 ]]; then
          # Spaceship
          source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
          autoload -U promptinit; promptinit

          # fzf keybindings + completion (needs a terminal; not for zshenv)
          source <(fzf --zsh)

          # Swag
          pfetch
        fi
      '';
    };
  };
}
