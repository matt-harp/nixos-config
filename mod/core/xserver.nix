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
    # displayManager.sddm.wayland.enable = true;
    desktopManager.gnome.enable = true;
  };
  # To prevent getting stuck at shutdown
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };
}
