{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    
    extraConfig = ''
      # Enable mouse support
      set -g mouse on
      
      # Better colors
      set -ga terminal-overrides ",*256col*:Tc"
      
      # Status bar
      set -g status-style 'bg=#1a1b26 fg=#a9b1d6'
      set -g status-left '#[fg=#7aa2f7,bold] #S '
      set -g status-right '#[fg=#bb9af7] %H:%M '
    '';
  };
}