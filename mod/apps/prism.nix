{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.prism;
in
{
  options.apps.prism = {
    enable = lib.mkEnableOption "PrismLauncher";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [ ".local/share/PrismLauncher" ];

    environment.systemPackages = [ pkgs.prismlauncher ];
  };
}
