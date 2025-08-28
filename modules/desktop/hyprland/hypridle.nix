{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        on_unlock_cmd = "killall waybar || true && setsid uwsm app -- waybar &>/dev/null &";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        # {
        #   timeout = 295;
        #   on-timeout = "killall waybar";
        #   on-resume = "exec waybar";
        # }
      ];
    };
  };
}
