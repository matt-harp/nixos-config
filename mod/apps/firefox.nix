{
  config,
  lib,
  ...
}:
let
  cfg = config.apps.firefox;
in
{
  options.apps.firefox = {
    enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
        ".cache/mozilla/firefox"
        ".mozilla/firefox"
      ];

      homeConfig = {
        programs.firefox = {
          enable = true;
        };
      };
    };
  };
}