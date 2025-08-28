{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "hypridle & mako & waybar & fcitx5"
      "waybar"

      "systemctl --user start hyprpolkitagent"
      "wl-clip-persist --clipboard regular & clipse -listen"
    ];
    #
    # exec = [
    #   "pkill -SIGUSR2 waybar || waybar"
    # ];
  };
}
