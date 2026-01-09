{
  config,
  lib,
  ...
}:
let
  cfg = config.apps.zoxide;
in
{
  options.apps.zoxide = {
    enable = lib.mkEnableOption "zoxide";
  };

  config = lib.mkIf cfg.enable {
    user = {
      homeConfig = {
        programs.zoxide = {
          enable = true;
        };
      };
    };
  };
}
