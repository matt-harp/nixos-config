{
  config,
  lib,
  ...
}:
let
  cfg = config.tools.direnv;
in
{
  options.tools.direnv = {
    enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
        ".config/direnv"
        ".local/share/direnv"
      ];

      homeConfig = {
        programs.direnv = {
          enable = true;
          enableBashIntegration = true; # todo hook up to shell option
          nix-direnv.enable = true;
        };
      };
    };
  };
}
