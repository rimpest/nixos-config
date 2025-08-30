{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Version control
    gh
    lazygit
    
    # Development environments
    devenv
    
    # Docker
    docker-compose
    
    # Database tools
    postgresql_18
    pgcli
    pgadmin4
  ];
}