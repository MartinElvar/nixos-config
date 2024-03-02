{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;            # Auto suggest options and highlights syntax, searches in history for options
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      ohMyZsh = {                               # Extra plugins for zsh
        enable = true;
        plugins = [ "git" ];
      };

      interactiveShellInit = ''
        # Spaceship
        source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
        autoload -U promptinit; promptinit

        # Swag
        pfetch                                  # Show fetch logo on terminal start
      '';

      shellInit = ''                            # Zsh theme
        # Hook direnv
#       emulate zsh -c "$(direnv hook zsh)"
        # export PATH=~/.npm-packages/bin:$PATH
      '';
    };
  };
}
