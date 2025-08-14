{ username, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  # To prevent getting stuck at shutdown
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
