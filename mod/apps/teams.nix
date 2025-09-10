{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.teams;
in
{
  options.apps.teams = {
    enable = lib.mkEnableOption "Microsoft Teams";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [
      ".config/teams-for-linux"
    ];

    environment.systemPackages = with pkgs; [
      teams-for-linux
    ];
  };
}
