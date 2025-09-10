{
  config,
  lib,
  ...
}:
let
  cfg = config.apps.godot;
in
{
  options.apps.godot = {
    enable = lib.mkEnableOption "Godot";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [ ".config/godot" ];
  };
}
