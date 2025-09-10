{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.apps.spotify;
in
{
  options.apps.spotify = {
    enable = lib.mkEnableOption "Spotify Client";
  };

  config = lib.mkIf cfg.enable {
    user = {
      persist.directories = [
        ".config/spotify"
        ".cache/spotify"
        ".cache/spot"
      ];
    };

    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
