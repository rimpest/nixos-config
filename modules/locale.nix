{ config, pkgs, lib, ... }:

{
  time.timeZone = "America/Monterrey";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_MX.UTF-8";
      LC_MONETARY = "es_MX.UTF-8";
      LC_TIME = "es_MX.UTF-8";
    };
  };
}