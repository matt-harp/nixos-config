{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.lutris;
  dotnet-combined = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_9_0_1xx-bin
    ]
  );
in
{
  options.apps.lutris = {
    enable = lib.mkEnableOption "Lutris";
  };

  config = lib.mkIf cfg.enable {
    user.persist = {
      directories = [
        ".cache/lutris"
        ".config/lutris"
        ".local/share/lutris"
        ".cache/winetricks"
      ];
    };

    environment.systemPackages = with pkgs; [
      lutris
      # winetricks
      # wineWowPackages.waylandFull
    ];

    environment.sessionVariables = {
      DOTNET_ROOT = "${dotnet-combined}/share/dotnet/";
    };

  };
}
