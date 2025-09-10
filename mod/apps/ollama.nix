{
  config,
  lib,
  ...
}:
let
  cfg = config.apps.ollama;
in
{
  options.apps.ollama = {
    enable = lib.mkEnableOption "ollama";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [ ".ollama/models" ];

    services.ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "12.0.1"; # todo make an option
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1201";
      };
    };
  };
}
