{ config, pkgs, lib, ... }:

{
  # GNOME user settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      scaling-factor = 1.5;
      font-name = "Futura PT Medium 11";  # Futura Medium as system font
      document-font-name = "Futura PT Book 11";
      monospace-font-name = "JetBrainsMonoNL Nerd Font 10";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      color-scheme = "prefer-dark";  # Optional: prefer dark theme
      accent-color = "teal";
    };
    
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = 4700;  # Warmer color temperature
    };
    
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Futura PT Demi 11";
      button-layout = "close,minimize,maximize:menu";
    };
    
    # Enable experimental fractional scaling per-monitor
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  # 1Password autostart
  xdg.configFile."autostart/1password.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=1Password
    Exec=${pkgs._1password-gui}/bin/1password --silent
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Comment=Start 1Password on login
  '';
}
