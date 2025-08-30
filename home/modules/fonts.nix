{ config, pkgs, lib, ... }:

{
  # Install custom fonts to user directory
  home.file = {
    ".local/share/fonts/JetBrainsMono" = {
      source = ../fonts/jetbrains-mono;
      recursive = true;
    };
    ".local/share/fonts/Futura" = {
      source = ../fonts/futura;
      recursive = true;
    };
  };
  
  # Enable font configuration for user
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Futura PT Medium 11"];
      monospace = [ "JetBrainsMonoNL Nerd Font" ];
      };
    };
}
