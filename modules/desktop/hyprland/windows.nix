{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hypr.land/Configuring/Core/Rules/Window-Rules/ for more
    window_rule = [
      {
        match.class = ".*";
        suppress_event = "maximize";
      }

      # Force chromium into a tile to deal with --app bug
      {
        match.class = "^(brave)$";
        tile = true;
      }

      # Settings management
      {
        match.class = "^(org.pulseaudio.pavucontrol|blueberry.py)$";
        float = true;
      }

      # Float Steam, fullscreen RetroArch
      {
        match.class = "^(steam)$";
        float = true;
      }

      # Float file pickers: the portal one (xdg-desktop-portal-gtk) and
      # in-browser GTK dialogs (must come after the brave tile rule to win)
      {
        match.class = "^(xdg-desktop-portal-gtk)$";
        float = true;
        center = true;
      }
      {
        match.class = "^(xdg-desktop-portal-gtk)$";
        size = [
          "monitor_w * 0.6"
          "monitor_h * 0.65"
        ];
      }
      {
        match.class = "^(chromium|google-chrome|google-chrome-unstable|brave)$";
        match.title = "^(Open File|Open Files|Save File|Save File As|File Upload|Select).*";
        float = true;
        center = true;
      }

      # Just dash of transparency
      {
        match.class = ".*";
        opacity = "0.97 0.9";
      }
      # Normal chrome Youtube tabs
      {
        match.class = "^(chromium|google-chrome|google-chrome-unstable|brave)$";
        match.title = ".*Youtube.*";
        opacity = "1 1";
      }
      {
        match.class = "^(chromium|google-chrome|google-chrome-unstable|brave)$";
        opacity = "1 0.97";
      }
      {
        # web apps
        match.initial_class = "^(chrome-.*-Default)$";
        opacity = "0.97 0.9";
      }
      {
        # Youtube
        match.initial_class = "^(chrome-youtube.*-Default)$";
        opacity = "1 1";
      }
      {
        match.class = "^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$";
        opacity = "1 1";
      }

      # Fix some dragging issues with XWayland
      {
        match.class = "^$";
        match.title = "^$";
        match.xwayland = true;
        float = true;
        fullscreen = false;
        pin = false;
        no_focus = true;
      }

      # Float in the middle for clipse clipboard manager
      {
        match.class = "clipse";
        float = true;
      }
      {
        match.class = "clipse";
        size = [
          622
          652
        ];
      }
      {
        match.class = "clipse";
        stay_focused = true;
      }
    ];

    layer_rule = [
      # Proper background blur for wofi
      {
        match.namespace = "launcher";
        blur = true;
      }
      # NOTE: this was "match:title waybar" in the old hyprlang config, but
      # layer rules only support matching on `namespace` - title was never a
      # valid match prop for layers, so this rule has likely always been a
      # no-op. Kept as-is (translated literally) rather than silently
      # "fixed" to `namespace = "waybar"` during this migration.
      {
        match.title = "waybar";
        blur = true;
      }
    ];
  };
}
