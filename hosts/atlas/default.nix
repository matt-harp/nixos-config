{ config, pkgs, ... }:

{
  imports = [
    ../../mod/core.nix
    ../../mod/gnome.nix
    ../../mod/1password.nix
    ../../mod/steam.nix

    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Set hostname
  networking.hostName = "atlas";
  networking.networkmanager.enable = true;

  # Enable blutooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    #settings = {
    #  General = {
    #	 Enable = "Source,Sink,Media,Socket";
    #  };
    #};
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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
    };
  };

  # For nvidia card
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    # save VRAM to swap on suspend
    powerManagement.enable = true;
    nvidiaSettings = true;
    open = true;
  };

  system.stateVersion = "24.11";
}
