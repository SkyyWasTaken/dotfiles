
{ config, pkgs, lib, ... }:

{
  options = with lib; with types; {
    hostname = mkOption { type = str; };
    defaultUser = mkOption { type = str; };
    gitUsername = mkOption { type = str; };
    gitEmail = mkOption { type = str; };
  };
  config = {
    hostname = "dogger-pc";
    defaultUser = "skyy";
    gitUsername = "SkyyWasTaken";
    gitEmail = "coolg0092002@gmail.com";
  };
}