{
  pkgs,
  lib,
  ...
}:
with lib;
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        margin = "6 6 6 6";

        modules-left = [
          "niri/workspaces"
          "mpris"
        ];
        modules-center = [ "custom/clock" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "battery"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        "mpris" = {
          format = "{player_icon} {artist} - {title}";
          format-paused = "{status_icon} <i>{artist} - {title}</i>";
          max-length = 30;
          player-icons = {
            default = "";
            spotify = "";
          };
          status-icons = {
            paused = "";
          };
          ignored-players = [
            "firefox"
            "chromium"
            "brave"
          ];
        };

        "custom/clock" = {
          exec = "date +'%d %b %-I:%M%p'";
          interval = 1;
        };

        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };

        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };

        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownBytes}";
          format-wifi = "{icon} {bandwidthDownBytes}";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 18;
          # icon-size = 24; # Scaled up icon size
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip = false;
        };
      }
    ];
    style = concatStrings [
      ''
        * {
          border: none;
          border-radius: 0;
          font-family: Roboto, JetBrainsMono Nerd Font Mono;
          font-size: 14px;

          min-height: 0px;
          margin: 0;
          padding: 0;
        }

        #workspaces,
        #mpris,
        #custom-clock,
        #tray,
        #pulseaudio,
        #network,
        #cpu,
        #memory {
          background: #1e1e2e;
          border: 1px solid #313244;
          border-radius: 8px;

          padding: 4px 8px 4px 8px;
        }

        #mpris, #pulseaudio, #network, #cpu, #memory {
          margin-left: 6px;
        }

        window#waybar {
          background: transparent;
        }

        tooltip {
          background: #1e1e2e;
          border: 1px solid #313244;
          border-radius: 6px;
        }

        #workspaces button {
          padding: 0px 8px;
          color: #282936;
        }
        #workspaces button.active {
          color: #89b4fa;
        }
        #tray > .passive {
          -gtk-icon-effect: dim;
        }
        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
        }
      ''
    ];
  };
}
