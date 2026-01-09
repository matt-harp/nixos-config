{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.zed;
in
{
  options.apps.zed = {
    enable = lib.mkEnableOption "Zed Editor";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
        ".cache/zed"
        ".config/zed"
        ".local/share/zed"
      ];

      homeConfig = {
        programs.zed-editor = {
          enable = true;
        };
      };
    };
  };
}
