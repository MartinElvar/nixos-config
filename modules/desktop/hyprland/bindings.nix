{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    # Only display the OSD on the currently focused monitor
    "$osdclient" =
      "swayosd-client --monitor \"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')\"";

    bind = [
      "SUPER, space, exec, wofi --show drun --sort-order=alphabetical"

      "$mod, Q, killactive,"
      "ALT, Tab, cyclenext"
      "ALT, Tab, bringactivetotop"

      # Resize active window
      "$mod, minus, resizeactive, -100 0"
      "$mod, equal, resizeactive, 100 0"
      "$mod SHIFT, minus, resizeactive, 0 -100"
      "$mod SHIFT, equal, resizeactive, 0 100"

      # Scroll through existing workspaces with SUPER + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Apps
      "SUPER, A, exec, $webapp=https://chatgpt.com"
      "SUPER SHIFT, A, exec, $webapp=https://grok.com"
      "SUPER, C, exec, thinderbird"
      "SUPER, Y, exec, $webapp=https://youtube.com/"
      "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"
      "SUPER, X, exec, $webapp=https://x.com/"

      "SUPER, return, exec, $terminal"
      "SUPER, F, exec, $fileManager"
      "SUPER, B, exec, $browser"
      "SUPER, M, exec, $music"
      "SUPER, N, exec, $terminal -e nvim"
      "SUPER, T, exec, $terminal -e btop"
      "SUPER, G, exec, $messenger"
      "SUPER, O, exec, obsidian -disable-gpu"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindld = [
      # Requires playerctl
      ", XF86AudioNext, Next track, exec, $osdclient --playerctl next"
      ", XF86AudioPause, Pause, exec, $osdclient --playerctl play-pause"
      ", XF86AudioPlay, Play, exec, $osdclient --playerctl play-pause"
      ", XF86AudioPrev, Previous track, exec, $osdclient --playerctl previous"
    ];

    bindeld = [
      # Laptop multimedia keys for volume and LCD brightness (with OSD)
      ",XF86AudioRaiseVolume, Volume up, exec, $osdclient --output-volume raise"
      ",XF86AudioLowerVolume, Volume down, exec, $osdclient --output-volume lower"
      ",XF86AudioMute, Mute, exec, $osdclient --output-volume mute-toggle"
      ",XF86MonBrightnessUp, Brightness up, exec, $osdclient --brightness raise"
      ",XF86MonBrightnessUp, Brightness up, exec, $osdclient --brightness raise"
      ",XF86MonBrightnessDown, Brightness down, exec, $osdclient --brightness lower"
    ];
  };
}
