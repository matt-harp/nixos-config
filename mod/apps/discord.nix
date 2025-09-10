{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.discord;
in
{
  options.apps.discord = {
    enable = lib.mkEnableOption "Discord Client";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [ ".config/discord" ];

    environment.systemPackages = [
      pkgs.discord
    ];
  };
}
