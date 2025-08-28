{
  config,
  nix-colors,
  ...
}:
let
  palette = config.colorScheme.palette;
  convert = nix-colors.lib.conversions.hexToRGBString;
  backgroundRgb = "rgb(${convert ", " palette.base00})";
  foregroundRgb = "rgb(${convert ", " palette.base05})";
in
{
  home.file = {
    ".config/waybar/" = {
      source = ./config/waybar;
      recursive = true;
    };
    ".config/waybar/theme.css" = {
      text = ''
        @define-color background ${backgroundRgb};
        * {
          color: ${foregroundRgb}; 
        }

        window#waybar {
          background-color: ${backgroundRgb};
        }
      '';
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock#date"
          "clock#time"
        ];
        modules-right = [
          "tray"
          "bluetooth"
          "network"
          "wireplumber"
          "cpu"
          "temperature"
          "memory"
          "power-profiles-daemon"
          "battery"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };
        cpu = {
          interval = 5;
          format = "󰍛 {usage}%";
          format-warning = "󰀨 {usage}%";
          format-critical = "󰀨 {usage}%";
          states = {
            warning = 75;
            critical = 90;
          };
          on-click = "alacritty -e btop";
        };
        "clock#time" = {
          format = "{:%a %H:%M}";
          tooltip = false;
        };
        "clock#date" = {
          "format" = "󰸗 {:%d-%m}";
          tooltip-format = "{calendar}";
          calendar = {
            mode = "month";
            mode-mon-col = 6;
            format = {
              months = "<span alpha='100%'><b>{}</b></span>";
              days = "<span alpha='90%'>{}</span>";
              # weeks
              weekdays = "<span alpha='80%'><i>{}</i></span>";
              today = "<span alpha='100%'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click = "mode";
          };
        };
        network = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "alacritty -e nmcli";
        };
        battery = {
          format = "{icon} {capacity}% ";
          format-time = "{H} h {M} m";
          format-discharging = "{icon} {capacity}% ";
          format-charging = "󰉁 {capacity}% ";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
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
          };
          format-full = "Charged ";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}% - {time}";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}% - {time}";
          states = {
            warning = 20;
            critical = 10;
          };
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };
        wireplumber = {
          # Changed from "pulseaudio"
          "format" = "";
          format-muted = "󰝟";
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip-format = "Playing at {volume}%";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; # Updated command
          max-volume = 150; # Optional: allow volume over 100%
        };
        tray = {
          spacing = 13;
        };
        temperature = {
          thermal-zone = 1;
          critical-threshold = 90;
          interval = 10;
          format-critical = "󰀦 {temperatureC}°C";
          format = "{icon} {temperatureC}°C";
          format-icons = [
            "󱃃"
            "󰔏"
            "󱃂"
          ];
          min-length = 8;
          max-length = 8;
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            power-saver = "󰡳";
            balanced = "󰊚";
            performance = "󰡴";
          };
        };
        memory = {
          interval = 10;
          format = "󰘚 {percentage}% ";
          format-warning = "󰀧 {percentage}% ";
          format-critical = "󰀧 {percentage}% ";
          states = {
            warning = 75;
            critical = 90;
          };
          tooltip-format = "Memory Used: {used:0.1f} GB / {total:0.1f} GB";
        };
      }
    ];
  };
}
