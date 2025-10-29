{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, r, exec, wofi --show drun --sort-order=alphabetical"
      "SUPER SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"

      "SUPER, ESCAPE, exec, hyprlock"
      "SUPER SHIFT, ESCAPE, exit,"
      "SUPER CTRL, ESCAPE, exec, reboot"
      "SUPER SHIFT CTRL, ESCAPE, exec, systemctl poweroff"

      "SUPER, Q, killactive,"
      "ALT, Tab, cyclenext"
      "ALT, Tab, bringactivetotop"

      # Navigation
      "SUPER, h, movefocus, l"
      "SUPER, l, movefocus, r"
      "SUPER, j, movefocus, u"
      "SUPER, k, movefocus, d"

      # Layout
      "SUPER, Backspace, layoutmsg, swapwithmaster master"
      "SUPER, SPACE, layoutmsg, orientationcycle left center right"

      "SUPER, minus, resizeactive, -100 0"
      "SUPER, equal, resizeactive, 100 0"
      "SUPER, Tab, fullscreenstate, 2 0"

      # Scroll through existing workspaces with SUPER + scroll
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"

      # Apps
      "SUPER, A, exec, $webapp=https://chatgpt.com"
      "SUPER SHIFT, A, exec, $webapp=https://grok.com"
      "SUPER, C, exec, thinderbird"
      "SUPER, Y, exec, $webapp=https://youtube.com/"
      "SUPER, X, exec, $webapp=https://x.com/"
      "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"

      "SUPER, return, exec, $terminal"
      "SUPER, F, exec, $fileManager"
      "SUPER, B, exec, $browser"
      "SUPER, M, exec, $music"
      "SUPER, N, exec, $terminal -e nvim"
      "SUPER, T, exec, $terminal -e btop"
      "SUPER, G, exec, $messenger"
      "SUPER, O, exec, obsidian -disable-gpu"

      # Super workspace floating layer
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER SHIFT, S, movetoworkspace, special:magic"

      # Screenshots
      ", PRINT, exec, hyprshot -m region"
      "SHIFT, PRINT, exec, hyprshot -m window"
      "CTRL, PRINT, exec, hyprshot -m output"

      # Color picker
      "SUPER, PRINT, exec, hyprpicker -a"

      # Clipse
      "CTRL ALT, V, exec, alacritty --class clipse -e clipse"
    ]
    ++ (
      # workspaces
      # binds SUPER + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "SUPER, code:1${toString i}, workspace, ${toString ws}"
            "SUPER SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );

    bindc = [

    ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness (with OSD)
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];
  };
}
