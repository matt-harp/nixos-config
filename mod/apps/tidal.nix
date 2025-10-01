{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.tidal;
in
{
  options.apps.tidal = {
    enable = lib.mkEnableOption "Tidal HiFi Electron Client";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
        ".config/tidal-hifi"
      ];
    };

    environment.systemPackages = with pkgs; [
      tidal-hifi
    ];
  };
}
