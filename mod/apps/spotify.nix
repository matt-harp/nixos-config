{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    spot
    spotify
  ];

  user = {
    persist.directories = [
      ".config/spotify"
      ".cache/spotify"
      ".cache/spot"
    ];
  };
}
