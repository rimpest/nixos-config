{ config, pkgs, lib, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Display manager for Hyprland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable XDG desktop portal for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Wayland utilities
    wl-clipboard
    wl-clipboard-x11
    wayland-utils

    # Screenshot utilities
    grim
    slurp
    swappy

    # Notification daemon
    mako

    # Authentication agent
    polkit-kde-agent
  ];

  # Security - required for screen sharing
  security.polkit.enable = true;

  # Ensure pipewire is enabled for screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
