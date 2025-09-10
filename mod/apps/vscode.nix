{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.vscode;
in
{
  options.apps.vscode = {
    enable = lib.mkEnableOption "VSCodium";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
      nil # Nix lanugage server
    ];

    user = {
      persist.directories = [
        ".config/VSCodium"
        ".vscode-oss"
        ".continue"
      ];

      homeConfig = {
        programs.vscode = {
          enable = true;

          package = pkgs.vscodium;
          profiles.default = {
            extensions = with pkgs.vscode-extensions; [
              editorconfig.editorconfig

              jnoortheen.nix-ide # Nix

              continue.continue
            ];
          };
        };
      };
    };
  };
}
