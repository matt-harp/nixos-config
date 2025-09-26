{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.helix;
in
{
  options.apps.helix = {
    enable = lib.mkEnableOption "Helix";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
      ];

      homeConfig = {
        programs.helix = {
          enable = true;

          settings = {
            theme = "catpuccin-mocha";
            editor.cursor-shape = {
              normal = "block";
              insert = "bar";
              select = "underline";
            };
          };
          languages.language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
            }
          ];
        };
      };
    };
  };
}
