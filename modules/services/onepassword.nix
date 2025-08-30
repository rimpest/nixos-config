{ config, pkgs, lib, ... }:

{
  # Enable 1Password at system level
  programs._1password.enable = true;
  
  # Enable 1Password GUI with PolKit integration
  programs._1password-gui = {
    enable = true;
    # Enable PolKit integration for CLI and browser extension support
    polkitPolicyOwners = [ "rimpest" ];
  };

  # Environment configuration for browser native messaging
  environment.etc = {
    # Allow custom browsers if needed (e.g., Vivaldi)
    "1password/custom_allowed_browsers" = {
      text = ''
        # Add any custom browser binary names here if needed
      '';
      mode = "0755";
    };
  };
}