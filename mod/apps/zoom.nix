{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    zoom-us
  ];

  user.persist = {
    # files = [
    #   ".config/zoom.conf"
    #   ".config/zoomus.conf"
    # ];
    directories = [
      ".cache/zoom"
    ];
  };
}