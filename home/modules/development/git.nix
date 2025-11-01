{ config, pkgs, lib, ... }:

{
  # Omarchy provides basic git config, this adds GPG signing with 1Password
  programs.git = {
    settings = {
      # Override omarchy git values if needed
      user.name = lib.mkForce "rimpest-nix";
      user.email = lib.mkForce "rimpest@gmail.com";

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