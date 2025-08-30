{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Python development tools
    poetry
    ruff
    black
    mypy
  ];
}