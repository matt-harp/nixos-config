{
  pkgs,
  inputs,
  ...
}:
let
  package = pkgs.vesktop;
in
{
  environment.systemPackages = [
    package
  ];

  user = {
    persist.directories = [ ".config/vesktop" ];
    homeConfig = {
      imports = [ inputs.nixcord.homeModules.nixcord ];
      programs.nixcord = {
        enable = true;
        discord.enable = false;
        vesktop = {
          enable = true;
          inherit package;
        };

        config = {
          plugins = {
            fixSpotifyEmbeds.enable = true;
          };
        };
      };
    };
  };
}