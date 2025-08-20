{
  pkgs,
  ...
}:
let
  package = pkgs.vscodium;
in
{
  environment.systemPackages = [
    package
    pkgs.nil # Nix lanugage server
  ];

  user = {
    persist.directories = [
      ".config/VSCodium"
      ".vscode-oss"
    ];

    homeConfig = {
      programs.vscode = {
        enable = true;

        inherit package;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            editorconfig.editorconfig

            jnoortheen.nix-ide # Nix
          ];
        };
      };
    };
  };
}