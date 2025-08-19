{ 
  inputs,
  pkgs,
  ...
}:
# let
#   spice = inputs.spicetify-nix.legacyPackages.${pkgs.system};
# in
{
  environment.systemPackages = with pkgs; [
    spotify
    # spicetify-cli
  ];

  user = {
    persist.directories = [
      ".config/spotify"
      ".cache/spotify"
    ];

    # homeConfig = {
    #   imports = [ inputs.spicetify-nix.homeManagerModules.default ];
    #   programs.spicetify = {
    #     enable = true;

    #     # Player Improvements
    #     enabledCustomApps = with spice.apps; [
    #       betterLibrary
    #       localFiles
    #       newReleases
    #     ];

    #     enabledExtensions = with spice.extensions; [
    #       beautifulLyrics
    #       goToSong
    #       history
    #       loopyLoop
    #       playNext
    #       popupLyrics
    #       seekSong
    #       showQueueDuration
    #       volumePercentage
    #     ];

    #     theme = spice.themes.catppuccin;
    #     colorScheme = "mocha";
    #   };
    # };
  };
}
