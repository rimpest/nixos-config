{ config, pkgs, lib, ... }:

{
  # Framework laptop specific hardware support
  services.fprintd.enable = true;
  services.fwupd.enable = true;
}