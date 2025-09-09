{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    teams-for-linux
  ];

  user.persist = {
    directories = [
      ".config/teams-for-linux"
    ];
  };
}