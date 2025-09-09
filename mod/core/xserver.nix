{ username, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = [ "amdgpu" ];
    };

    displayManager.autoLogin = {
      enable = false;
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
