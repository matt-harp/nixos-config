{ pkgs, ... }:
{
  user.persist.directories = [
    ".config/easyeffects"
    ".local/state/wireplumber"
  ];
  # hardware.alsa.enablePersistence = true;
  environment.systemPackages = with pkgs; [
    easyeffects
    pavucontrol
  ];

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-mitigate-annoying-profile-switch.conf" ''
          wireplumber.settings = {
            bluetooth.autoswitch-to-headset-profile = false
          }

          monitor.bluez.properties = {
            bluez5.roles = [ a2dp_sink a2dp_source ]
          }
        '')
      ];
      extraConfig = {
        "disable-hdmi" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "device.name" = "alsa_card.pci-0000_28_00.1";
                }
              ];
              actions = {
                update-props = {
                  "device.disabled" = true;
                };
              };
            }
          ];
        };
      };
    };
  };

  systemd.user.services.easyeffects = {
    description = "EasyEffects daemon";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service --load-preset Default";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
