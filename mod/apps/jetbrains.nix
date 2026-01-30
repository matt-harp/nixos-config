{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.jetbrains;
in
{
  options.apps.jetbrains = {
    enable = lib.mkEnableOption "JetBrains";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".java/.userPrefs/jetbrains/" # wtf?
    ];

    environment.systemPackages = [
      pkgs.jetbrains.idea
    ];
  };
}
