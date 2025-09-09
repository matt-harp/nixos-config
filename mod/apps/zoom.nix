{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    zoom-us
  ];

  user.persist = {
    directories = [
      ".cache/zoom"
    ];
  };
}