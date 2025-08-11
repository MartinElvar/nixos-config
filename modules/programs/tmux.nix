{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    shortcut = "Space";
    extraConfig = ''
    unbind r
    bind r source-file ~/.tmux.conf

    bind-key h select-pane -L
    bind-key l select-pane -R
    bind-key j select-pane -D
    bind-key k select-pane -U
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.fingers
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set-option -g status-position top
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style 'rounded'
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_session}"
        '';
      }
    ];
  };
}
