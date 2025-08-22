{ pkgs, ... }:
{
  user = {
    persist.files = [
      ".config/monitors.xml"
    ];

    homeConfig = {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          clock-format = "12h";
          clock-show-weekday = true;
          enable-hot-corners = false;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":minimize,maximize,close";
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
        };
        "org/gnome/mutter" = {
          edge-tiling = true;
        };
        "org/gnome/shell" = {
          welcome-dialog-last-shown-version = "999"; # prevent popup until gnome version 999 :)
        };
      };
    };
  };
  environment.gnome.excludePackages = with pkgs; [
    # baobab      # disk usage analyzer
    cheese      # photo booth
    # eog         # image viewer
    epiphany    # web browser
    # gedit       # text editor
    simple-scan # document scanner
    # totem       # video player
    yelp        # help viewer
    # evince      # document viewer
    # file-roller # archive manager
    geary       # email client
    # seahorse    # password manager

    # these should be self explanatory
    # gnome-calculator
    gnome-calendar
    # gnome-characters
    gnome-clocks
    # gnome-contacts
    # gnome-font-viewer
    # gnome-logs
    gnome-maps
    gnome-music
    # gnome-photos
    # gnome-screenshot
    # gnome-system-monitor
    gnome-weather
    # gnome-disk-utility
    gnome-connections
  ];
}