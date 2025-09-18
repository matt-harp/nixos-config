{
  config,
  lib,
  ...
}:
let
  cfg = config.apps.zoom;
in
{
  options.apps.zoom = {
    enable = lib.mkEnableOption "Zoom Client";
  };

  config = lib.mkIf cfg.enable {
    user.persist = {
      directories = [
        ".cache/zoom"
        ".zoom"
      ];
    };

    programs.zoom-us.enable = true;
  };
}
