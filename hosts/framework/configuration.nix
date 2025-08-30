{ config, pkgs, lib, ... }:

{
  imports = [
    # Core system
    ../../modules/core/boot.nix
    ../../modules/core/nix.nix
    ../../modules/core/system.nix
    
    # Hardware
    ../../modules/hardware/framework.nix
    
    # Networking
    ../../modules/networking
    
    # Desktop environment
    ../../modules/desktop/gnome.nix
    
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

  system.stateVersion = "25.05";
}