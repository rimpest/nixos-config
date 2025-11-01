{ config, pkgs, lib, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Nerd Fonts - only JetBrains Mono for terminal/code
      nerd-fonts.jetbrains-mono
      
      # System fonts
      liberation_ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji  # Renamed from noto-fonts-emoji
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Liberation Serif" ];
        sansSerif = [ "Liberation Sans" ];
        monospace = [ "JetBrainsMonoNL Nerd Font" ];
      };
    };
  };
}