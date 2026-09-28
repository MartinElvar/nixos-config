{
  lib,
  ...
}:

let
  inherit (lib.generators) mkLuaInline;

  # A bind with no flags: key + a raw hl.dsp... lua expression.
  b = key: dsp: {
    _args = [
      key
      (mkLuaInline dsp)
    ];
  };

  # A bind with flags (locked/repeating/mouse/...).
  bf = key: dsp: opts: {
    _args = [
      key
      (mkLuaInline dsp)
      opts
    ];
  };
in

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      (b "SUPER + r" ''hl.dsp.exec_cmd("wofi --show drun --sort-order=alphabetical")'')
      (b "SUPER + SHIFT + SPACE" ''hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")'')

      (b "SUPER + ESCAPE" ''hl.dsp.exec_cmd("hyprlock")'')
      (b "SUPER + SHIFT + ESCAPE" "hl.dsp.exit()")
      (b "SUPER + CTRL + ESCAPE" ''hl.dsp.exec_cmd("reboot")'')
      (b "SUPER + SHIFT + CTRL + ESCAPE" ''hl.dsp.exec_cmd("systemctl poweroff")'')

      (b "SUPER + Q" "hl.dsp.window.close()")
      {
        # cyclenext + bringactivetotop used to be two separate bind= lines
        # on the same key; combined into one bind with a function body.
        _args = [
          "ALT + Tab"
          (mkLuaInline ''
            function()
              hl.dispatch(hl.dsp.window.cycle_next())
              hl.dispatch(hl.dsp.window.bring_to_top())
            end
          '')
        ];
      }

      # Navigation
      (b "SUPER + h" ''hl.dsp.focus({ direction = "l" })'')
      (b "SUPER + l" ''hl.dsp.focus({ direction = "r" })'')
      (b "SUPER + j" ''hl.dsp.focus({ direction = "u" })'')
      (b "SUPER + k" ''hl.dsp.focus({ direction = "d" })'')

      # Layout
      (b "SUPER + Backspace" ''hl.dsp.layout("swapwithmaster master")'')
      (b "SUPER + SPACE" ''hl.dsp.layout("orientationcycle left center right")'')

      (b "SUPER + minus" "hl.dsp.window.resize({ x = -100, y = 0, relative = true })")
      (b "SUPER + equal" "hl.dsp.window.resize({ x = 100, y = 0, relative = true })")
      (b "SUPER + Tab" "hl.dsp.window.fullscreen_state({ internal = 2, client = 0 })")

      # Scroll through existing workspaces with SUPER + scroll
      (b "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
      (b "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')

      # Apps
      (b "SUPER + A" ''hl.dsp.exec_cmd(webapp .. "=https://chatgpt.com")'')
      (b "SUPER + SHIFT + A" ''hl.dsp.exec_cmd(webapp .. "=https://grok.com")'')
      (b "SUPER + C" ''hl.dsp.exec_cmd("thinderbird")'')
      (b "SUPER + Y" ''hl.dsp.exec_cmd(webapp .. "=https://youtube.com/")'')
      (b "SUPER + X" ''hl.dsp.exec_cmd(webapp .. "=https://x.com/")'')
      (b "SUPER + SHIFT + G" ''hl.dsp.exec_cmd(webapp .. "=https://web.whatsapp.com/")'')

      (b "SUPER + return" "hl.dsp.exec_cmd(terminal)")
      (b "SUPER + F" "hl.dsp.exec_cmd(fileManager)")
      (b "SUPER + B" "hl.dsp.exec_cmd(browser)")
      (b "SUPER + M" "hl.dsp.exec_cmd(music)")
      (b "SUPER + N" ''hl.dsp.exec_cmd(terminal .. " -e hx")'')
      (b "SUPER + T" ''hl.dsp.exec_cmd(terminal .. " -e btop")'')
      (b "SUPER + G" "hl.dsp.exec_cmd(messenger)")
      (b "SUPER + O" ''hl.dsp.exec_cmd("obsidian -disable-gpu")'')

      # Super workspace floating layer
      (b "SUPER + S" ''hl.dsp.workspace.toggle_special("magic")'')
      (b "SUPER + SHIFT + S" ''hl.dsp.window.move({ workspace = "special:magic" })'')

      # Screenshots
      (b "PRINT" ''hl.dsp.exec_cmd("hyprshot -m region")'')
      (b "SHIFT + PRINT" ''hl.dsp.exec_cmd("hyprshot -m window")'')
      (b "CTRL + PRINT" ''hl.dsp.exec_cmd("hyprshot -m output")'')

      # Color picker
      (b "SUPER + PRINT" ''hl.dsp.exec_cmd("hyprpicker -a")'')

      # Monitors: toggle mirroring, arrange ad-hoc layouts
      (b "SUPER + P" ''hl.dsp.exec_cmd("hypr-mirror")'')
      (b "XF86Display" ''hl.dsp.exec_cmd("hypr-mirror")'')
      (b "SUPER + SHIFT + P" ''hl.dsp.exec_cmd("nwg-displays")'')

      # Clipse
      (b "CTRL + ALT + V" ''hl.dsp.exec_cmd("alacritty --class clipse -e clipse")'')

      # Move/resize windows with mainMod + LMB/RMB and dragging
      (bf "SUPER + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
      (bf "SUPER + mouse:273" "hl.dsp.window.resize()" { mouse = true; })

      # Requires playerctl (locked: also works while the session is locked)
      (bf "XF86AudioNext" ''hl.dsp.exec_cmd("playerctl next")'' { locked = true; })
      (bf "XF86AudioPause" ''hl.dsp.exec_cmd("playerctl play-pause")'' { locked = true; })
      (bf "XF86AudioPlay" ''hl.dsp.exec_cmd("playerctl play-pause")'' { locked = true; })
      (bf "XF86AudioPrev" ''hl.dsp.exec_cmd("playerctl previous")'' { locked = true; })

      # Laptop multimedia keys for volume and LCD brightness (with OSD)
      (bf "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'' {
        repeating = true;
        locked = true;
      })
      (bf "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'' {
        repeating = true;
        locked = true;
      })
      (bf "XF86AudioMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'' {
        repeating = true;
        locked = true;
      })
      (bf "XF86AudioMicMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'' {
        repeating = true;
        locked = true;
      })
      (bf "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+")'' {
        repeating = true;
        locked = true;
      })
      (bf "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-")'' {
        repeating = true;
        locked = true;
      })
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
            (b "SUPER + code:1${toString i}" "hl.dsp.focus({ workspace = ${toString ws} })")
            (b "SUPER + SHIFT + code:1${toString i}" "hl.dsp.window.move({ workspace = ${toString ws} })")
          ]
        ) 9
      )
    );
  };
}
