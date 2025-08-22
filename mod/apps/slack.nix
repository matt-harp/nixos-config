{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    slack
  ];

  user.persist.directories = [];
}