{ 
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    spotify
  ];

  user = {
    persist.directories = [
      ".config/spotify"
      ".cache/spotify"
    ];
  };
}
