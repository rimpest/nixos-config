{ config, pkgs, lib, ... }:

{
  # Omarchy provides basic git config, this adds GPG signing with 1Password
  programs.git = {
    # Override omarchy git values if needed
    userName = lib.mkForce "rimpest-nix";
    userEmail = lib.mkForce "rimpest@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "vim";
      pull.rebase = false;

      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHHYy6Ue5LGk6uStrRfyP4yOCTJO6WD5X30//ftXe3Y8";

      commit.gpgsign = true;
      gpg.format = "ssh";

      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
    };
  };
}