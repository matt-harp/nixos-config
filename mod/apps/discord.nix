{
  pkgs,
  ...
}:
let
  package = pkgs.discord;
in
{
  environment.systemPackages = [
    package
  ];

  user = {
    persist.directories = [ ".config/discord" ];
  };
}