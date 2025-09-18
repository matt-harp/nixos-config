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
            extensions = with pkgs.nix-vscode-extensions.open-vsx; [
              editorconfig.editorconfig

              jnoortheen.nix-ide # Nix

              continue.continue

              mkhl.direnv

              twxs.cmake

              kylinideteam.kylin-clangd
              kylinideteam.kylin-cmake-tools
              kylinideteam.cppdebug
            ];
          };
        };
      };
    };
  };
}
