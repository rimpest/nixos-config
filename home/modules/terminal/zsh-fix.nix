{ config, lib, ... }:

{
  # Fix for deprecated initExtra warning from external modules
  # This module intercepts any initExtra content and moves it to initContent
  config = lib.mkIf (config.programs.zsh.enable or false) {
    programs.zsh = {
      # Move any initExtra content to initContent
      initContent = lib.mkAfter (config.programs.zsh.initExtra or "");
      # Clear initExtra to suppress the warning
      initExtra = lib.mkForce "";
    };
  };
}