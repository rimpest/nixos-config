# NixOS Configuration

A modular NixOS configuration using Flakes and Home Manager, optimized for Framework laptop with AMD AI 300 series.

## Features

- **Flakes-based configuration** for reproducible builds
- **Home Manager** for user-level package management
- **GNOME Desktop** environment with customizations
- **Development tools**: Python, Git, editors (VSCode, Neovim)
- **Security**: 1Password integration for SSH and secrets management
- **Terminal**: Zsh with Ghostty, Tmux
- **Virtualization**: Docker support
- **Hardware optimization** for Framework AMD AI 300 series laptop

## Security Notice

⚠️ **Before Making This Repository Public:**

This repository contains some personal information that you should review:
- Email address in `home/modules/development/git.nix`
- Username references throughout the configuration
- SSH public key fingerprint
- Git session tokens in `.git/FETCH_HEAD` (should be excluded via `.gitignore`)

Consider replacing personal information with placeholders before making public.

## Prerequisites

Before using this configuration, you need:

1. A computer with NixOS installed (or ready to install NixOS)
2. Internet connection
3. Basic familiarity with terminal commands

## Installation

### Option 1: Fresh NixOS Installation

If you're installing NixOS from scratch:

#### Step 1: Boot NixOS Installation Media

1. Download NixOS ISO from [nixos.org](https://nixos.org/download.html)
2. Create a bootable USB drive
3. Boot from the USB drive

#### Step 2: Prepare the System

```bash
# Connect to internet (if using WiFi)
sudo systemctl start wpa_supplicant

# Partition your disk (example for /dev/sda)
sudo parted /dev/sda -- mklabel gpt
sudo parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sda -- set 1 esp on
sudo parted /dev/sda -- mkpart primary 512MiB 100%

# Format partitions
sudo mkfs.fat -F 32 -n boot /dev/sda1
sudo mkfs.ext4 -L nixos /dev/sda2

# Mount partitions
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
```

#### Step 3: Generate Initial Hardware Configuration

```bash
# Generate initial configuration
sudo nixos-generate-config --root /mnt

# This creates:
# /mnt/etc/nixos/configuration.nix
# /mnt/etc/nixos/hardware-configuration.nix
```

#### Step 4: Install Git and Clone This Repository

```bash
# Install git in the live environment
nix-shell -p git

# Clone this repository
cd /mnt/etc
sudo mv nixos nixos.backup  # Backup the generated config
sudo git clone https://github.com/rimpest/nixos-config.git nixos
cd nixos
```

#### Step 5: Customize for Your System

**IMPORTANT**: You must customize the configuration before installing:

```bash
# 1. Copy your hardware configuration
sudo cp /mnt/etc/nixos.backup/hardware-configuration.nix /mnt/etc/nixos/hosts/framework/hardware-configuration.nix

# 2. Edit configuration files to replace personal information
sudo nano hosts/framework/configuration.nix
# - Change the username from 'rimpest' to your username
# - Change the hostname from 'nixos' to your desired hostname

sudo nano home/rimpest.nix
# - Rename this file to match your username
# - Update username and homeDirectory

sudo nano flake.nix
# - Update the home-manager.users.rimpest line to use your username
# - Update the hostname if you changed it

sudo nano home/modules/development/git.nix
# - Update userName and userEmail with your information
# - Update or remove the user.signingkey
```

#### Step 6: Install NixOS

```bash
# Install NixOS with the flake configuration
sudo nixos-install --flake /mnt/etc/nixos#nixos

# Set root password when prompted
# The system will install all packages and configurations

# Reboot
sudo reboot
```

### Option 2: Existing NixOS System

If you already have NixOS installed:

#### Step 1: Install Git (if not already installed)

```bash
# Temporarily install git
nix-shell -p git

# Or add it to your current configuration
```

#### Step 2: Clone the Repository

```bash
# Clone to your preferred location
cd ~
git clone https://github.com/rimpest/nixos-config.git
cd nixos-config
```

#### Step 3: Backup Your Current Configuration

```bash
# Backup your existing configuration
sudo cp -r /etc/nixos /etc/nixos.backup
```

#### Step 4: Customize the Configuration

1. **Copy your hardware configuration:**
   ```bash
   cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/framework/hardware-configuration.nix
   ```

2. **Update personal information** (see customization section below)

3. **Review hardware modules:**
   - If you're not using a Framework AMD AI 300 laptop, edit `flake.nix` and remove/change the hardware module at line 38

#### Step 5: Build and Test

```bash
# Build the configuration (test without applying)
sudo nixos-rebuild build --flake ~/nixos-config#nixos

# If build succeeds, apply the configuration
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
```

#### Step 6: Move Configuration to /etc/nixos (Optional)

```bash
# For easier management, you can move the config to /etc/nixos
sudo rm -rf /etc/nixos
sudo cp -r ~/nixos-config /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

## Repository Structure

```
nixos-config/
├── flake.nix                 # Main flake configuration
├── flake.lock               # Locked dependencies
├── hosts/                   # Host-specific configurations
│   └── framework/
│       ├── configuration.nix        # Main system config
│       └── hardware-configuration.nix  # Hardware-specific settings
├── modules/                 # System-level modules
│   ├── core/               # Core system settings
│   │   ├── boot.nix       # Boot loader configuration
│   │   ├── nix.nix        # Nix settings (flakes, auto-gc)
│   │   └── system.nix     # System packages
│   ├── desktop/           # Desktop environment
│   │   └── gnome.nix     # GNOME configuration
│   ├── hardware/          # Hardware-specific
│   │   └── framework.nix  # Framework laptop settings
│   ├── networking/        # Network configuration
│   ├── services/          # System services
│   │   ├── audio.nix     # PipeWire audio
│   │   ├── onepassword.nix  # 1Password
│   │   ├── printing.nix  # CUPS printing
│   │   └── virtualization.nix  # Docker
│   ├── fonts.nix          # System fonts
│   └── locale.nix         # Timezone and locale
└── home/                   # Home Manager configurations
    ├── rimpest.nix         # User-specific config
    └── modules/            # User-level modules
        ├── desktop/        # Desktop apps and settings
        ├── development/    # Dev tools and editors
        ├── security/       # SSH, 1Password
        └── terminal/       # Shell, terminal emulator
```

## Customization Guide

### Change Username

1. Rename `home/rimpest.nix` to `home/YOUR_USERNAME.nix`
2. Edit the new file and update:
   ```nix
   username = "YOUR_USERNAME";
   homeDirectory = "/home/YOUR_USERNAME";
   ```
3. Edit `flake.nix` line 44:
   ```nix
   home-manager.users.YOUR_USERNAME = import ./home/YOUR_USERNAME.nix;
   ```
4. Edit `hosts/framework/configuration.nix` line 34-36:
   ```nix
   users.users.YOUR_USERNAME = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" "docker" ];
     shell = pkgs.zsh;
   };
   ```

### Change Hostname

1. Edit `hosts/framework/configuration.nix` line 31:
   ```nix
   networking.hostName = "YOUR_HOSTNAME";
   ```
2. Edit `flake.nix` line 32 (if you want to change the configuration name):
   ```nix
   YOUR_HOSTNAME = nixpkgs.lib.nixosSystem {
   ```
3. Update the rebuild command to use new name:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#YOUR_HOSTNAME
   ```

### Add/Remove Packages

**System packages:** Edit `modules/core/system.nix`

**User packages:** Edit `home/rimpest.nix` (or your renamed file)

**Development tools:** Edit files in `home/modules/development/`

### Change Desktop Environment

To switch from GNOME to another DE:

1. Comment out or remove the GNOME imports in `hosts/framework/configuration.nix`
2. Add your preferred DE module (you'll need to create it)

### Hardware-Specific Settings

If not using a Framework laptop:
1. Edit `flake.nix` line 38 and remove the Framework hardware module
2. Edit or remove `modules/hardware/framework.nix`

## Updating the System

### Update Flake Inputs

```bash
# Update all inputs
sudo nix flake update /etc/nixos

# Update specific input
sudo nix flake lock --update-input nixpkgs /etc/nixos
```

### Apply Updates

```bash
# Rebuild with updates
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

### Garbage Collection

```bash
# Remove old generations (older than 7 days)
sudo nix-collect-garbage --delete-older-than 7d

# Remove all old generations except current
sudo nix-collect-garbage -d
```

## Troubleshooting

### Build Fails

1. Check syntax errors:
   ```bash
   nix flake check /etc/nixos
   ```

2. View detailed build output:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#nixos --show-trace
   ```

### Rollback to Previous Generation

```bash
# List available generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Or select specific generation
sudo /nix/var/nix/profiles/system-{generation}-link/bin/switch-to-configuration switch
```

### Home Manager Conflicts

If you encounter file conflicts:

```bash
# Backup files are created with .backup extension (configured in flake.nix)
# Or force rebuild:
home-manager switch --flake /etc/nixos
```

## Managing Git Repository

### Track Changes

```bash
cd /etc/nixos
sudo git add .
sudo git commit -m "Update configuration"
sudo git push
```

### Pull Updates

```bash
cd /etc/nixos
sudo git pull
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

## Additional Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Wiki](https://nixos.wiki/)
- [Nix Package Search](https://search.nixos.org/)

## License

This configuration is provided as-is for personal use. Modify as needed for your system.
