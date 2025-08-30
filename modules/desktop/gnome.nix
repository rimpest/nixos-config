{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
  
  # New non-deprecated options for GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome = {
    enable = true;
    
    # Enable experimental fractional scaling
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  
  # Remove unwanted GNOME default applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-terminal
    geary
    epiphany
    gnome-tour
    gnome-music
    gnome-maps
    gnome-weather
    gnome-contacts
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-console
    totem  # GNOME Videos
    cheese # Webcam application
    simple-scan
    yelp   # Help viewer
    evince # Document viewer (if you prefer another PDF reader)
  ];
}