{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Omarchy Hyprland configuration
    inputs.omarchy-nix.nixosModules.default

    # Core system
    ../../modules/core/boot.nix
    ../../modules/core/nix.nix
    ../../modules/core/system.nix

    # Hardware
    ../../modules/hardware/framework.nix

    # Networking
    ../../modules/networking

    # Services
    ../../modules/services/audio.nix
    ../../modules/services/onepassword.nix
    ../../modules/services/printing.nix
    ../../modules/services/virtualization.nix

    # System configuration
    ../../modules/fonts.nix
    ../../modules/locale.nix
  ];

  # Host-specific configuration
  networking.hostName = "nixos";
  
  # User configuration
  users.users.rimpest = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # Omarchy configuration
  omarchy = {
    full_name = "rimpest-nix";
    email_address = "rimpest@gmail.com";
    theme = "tokyo-night";  # Options: tokyo-night, kanagawa, everforest, catppuccin, nord, gruvbox, gruvbox-light
    scale = 2;  # 2 for HiDPI, 1 for standard displays
    primary_font = "CaskaydiaMono Nerd Font 11";

    # Monitor configuration for Hyprland
    monitors = [
      ",preferred,auto,1.5"  # Maintains your 1.5x scaling
    ];

    # Customize quick app bindings
    quick_app_bindings = [
      "SUPER, return, exec, $terminal"
      "SUPER, F, exec, $fileManager"
      "SUPER, B, exec, $browser"
      "SUPER, N, exec, $terminal -e nvim"
      "SUPER, T, exec, $terminal -e btop"
      "SUPER, D, exec, $terminal -e lazydocker"
      "SUPER, O, exec, obsidian"
      "SUPER, slash, exec, $passwordManager"
    ];
  };

  system.stateVersion = "25.05";
}