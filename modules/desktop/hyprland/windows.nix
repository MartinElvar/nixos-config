{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      "match:class .*, suppress_event maximize"

      # Force chromium into a tile to deal with --app bug
      "match:class ^(brave)$, tile 1"

      # Settings management
      "match:class ^(org.pulseaudio.pavucontrol|blueberry.py)$, float 1"

      # Float Steam, fullscreen RetroArch
      "match:class ^(steam)$, float 1"

      # Just dash of transparency
      "match:class .*, opacity 0.97 0.9"
      # Normal chrome Youtube tabs
      "match:class ^(chromium|google-chrome|google-chrome-unstable|brave)$, match:title .*Youtube.*, opacity 1 1,"
      "match:class ^(chromium|google-chrome|google-chrome-unstable|brave)$, opacity 1 0.97"
      "match:initial_class ^(chrome-.*-Default)$, opacity 0.97 0.9 # web apps"
      "match:initial_class ^(chrome-youtube.*-Default)$, opacity 1 1 # Youtube"
      "match:class ^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$, opacity 1 1"

      # Fix some dragging issues with XWayland
      "match:class ^$, match:title ^$, match:xwayland 1, float 1, fullscreen 0, pin 0, no_focus 1"

      # Float in the middle for clipse clipboard manager
      "match:class clipse, float 1"
      "match:class clipse, size 622 652"
      "match:class clipse, stay_focused 1"
    ];

    layerrule = [
      # Proper background blur for wofi
      "match:namespace launcher, blur 1"
      "match:title waybar, blur 1"
    ];
  };
}
