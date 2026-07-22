{
  config,
  lib,
  ...
}:
let
  cfg = config.apps.whatsapp;
in
{
  options.apps.whatsapp = {
    enable = lib.mkEnableOption "Whatsapp";
  };

  config = lib.mkIf cfg.enable {
    user.persist = {
      directories = [
      ];
    };

    environment.systemPackages = with pkgs; [
      whatsapp-electron
    ];
  };
}
