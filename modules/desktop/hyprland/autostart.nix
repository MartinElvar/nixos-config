{
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # exec-once equivalent: run these only when Hyprland actually starts, not
    # on every `hyprctl reload` (a bare top-level hl.exec_cmd would re-run then).
    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function()
            hl.exec_cmd("waybar")
            hl.exec_cmd("systemctl --user start hyprpolkitagent")
            hl.exec_cmd("wl-clip-persist --clipboard regular & clipse -listen")
          end
        '')
      ];
    };
  };
}
