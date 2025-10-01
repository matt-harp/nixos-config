{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.qmk;
in
{
  options.apps.qmk = {
    enable = lib.mkEnableOption "QMK";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
        ".config/qmk"
      ];
    };

    environment.systemPackages = with pkgs; [ qmk ];

    hardware.keyboard.qmk.enable = true;
  };
}
