{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    # Browsers
    firefox
    
    # Productivity
    obsidian
    libreoffice
    
    # Communication
    teams-for-linux
    wasistlos  # WhatsApp client (formerly whatsapp-for-linux)
    
    # Claude Desktop
    inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-with-fhs
  ];

  # Claude Desktop desktop entry
  xdg.desktopEntries.claude-desktop = {
    name = "Claude Desktop";
    comment = "Claude AI Desktop Application";
    exec = "${inputs.claude-desktop.packages.${pkgs.system}.default}/bin/claude-desktop";
    icon = "claude-desktop";
    terminal = false;
    type = "Application";
    categories = [ "Network" "Chat" "Development" ];
    startupNotify = true;
  };
}
