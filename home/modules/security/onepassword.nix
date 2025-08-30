{ config, pkgs, lib, ... }:

{
  # Enable 1Password shell plugins
  programs._1password-shell-plugins = {
    enable = true;
    # Packages that will use 1Password shell plugins
    plugins = with pkgs; [
      gh
      awscli2
    ];
  };

  # 1Password packages are automatically installed by the shell plugins module
  # But we can ensure they're available
  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
  ];

  # Set 1Password as SSH auth socket
  home.sessionVariables = {
    SSH_AUTH_SOCK = lib.mkDefault "$HOME/.1password/agent.sock";
  };

  # 1Password systemd service
  systemd.user.services.onepassword-gui = {
    Unit = {
      Description = "1Password GUI";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}