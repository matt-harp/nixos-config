{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.vintagestory;
in
{
  options.apps.vintagestory = {
    enable = lib.mkEnableOption "Vintage Story";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [ ".config/Vintagestory" ];

    environment.systemPackages = [
      pkgs.vintagestory
    ];
  };
}
