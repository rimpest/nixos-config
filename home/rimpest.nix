{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # 1Password shell plugins module
    inputs.onepassword-shell-plugins.hmModules.default
    
    # Fonts (load first for UI configuration)
    ./modules/fonts.nix
    
    # Desktop environment
    ./modules/desktop/hyprland.nix
    ./modules/desktop/apps.nix
    
    # Terminal and shell
    ./modules/terminal/shell.nix
    ./modules/terminal/ghostty.nix
    ./modules/terminal/tmux.nix
    
    # Development tools
    ./modules/development/git.nix
    ./modules/development/python.nix
    ./modules/development/editors.nix
    ./modules/development/tools.nix
    
    # Security
    ./modules/security/onepassword.nix
    ./modules/security/ssh.nix
    
    # Fix for deprecated zsh initExtra (must be last)
    ./modules/terminal/zsh-fix.nix
  ];

  home = {
    username = "rimpest";
    homeDirectory = "/home/rimpest";
    stateVersion = "25.05";
    
    sessionVariables = {
      BROWSER = "firefox";
      TERMINAL = "ghostty";
    };
  };

  programs.home-manager.enable = true;
}