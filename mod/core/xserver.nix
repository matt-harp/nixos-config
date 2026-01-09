{ username, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ]; # todo move to niri
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = [ "amdgpu" ];
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    displayManager.defaultSession = "niri";
  };
  # To prevent getting stuck at shutdown
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
