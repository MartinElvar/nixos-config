{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # https://wiki.hypr.land/Configuring/Variables/#input
    config.input = {
      kb_layout = "us";
      kb_variant = "mac";
      # kb_model =
      kb_options = "caps:super";
      # kb_rules =

      follow_mouse = 1;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = false;
      };
    };

    # https://wiki.hypr.land/Configuring/Variables/#gestures
    # config.gestures = {
    # };
  };
}
