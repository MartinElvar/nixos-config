{
  pkgs,
  lib,
  nix-colors,
  ...
}:

{
  imports = [
    nix-colors.homeManagerModules.default
    ./autostart.nix
    ./bindings.nix
    ./env.nix
    ./input.nix
    ./looknfeel.nix
    ./windows.nix
    ./waybar.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./mako.nix
    ./wofi.nix
    ./kanshi.nix
  ];

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

  wayland.windowManager.hyprland.enable = true; # enable Hyprland
  wayland.windowManager.hyprland.configType = "lua";

  # uwsm owns the session targets (programs.hyprland.withUWSM). home-manager's
  # hyprland-session.target now sets PropagatesStopTo=graphical-session.target,
  # so its startup `systemctl --user stop hyprland-session.target` tears down
  # graphical-session.target and kills the compositor a second after login.
  wayland.windowManager.hyprland.systemd.enable = false;

  # nwg-displays (>=0.55-aware) writes ~/.config/hypr/monitors.lua and expects
  # the main config to `require("monitors")`; Hyprland auto-reloads on change.
  wayland.windowManager.hyprland.extraConfig = ''
    require("monitors")
  '';

  wayland.windowManager.hyprland.settings = {
    # Default applications
    terminal._var = "alacritty";
    fileManager._var = "nautilus --new-window";
    browser._var = "brave --new-window --ozone-platform=wayland";
    music._var = "spotify";
    messenger._var = "signal-desktop";
    webapp._var = lib.generators.mkLuaInline ''browser .. " --app"'';

    monitor = {
      # Always set up the laptop panel
      # output = "eDP-1"; mode = "preferred"; position = "0x0"; scale = 1;
      # Fallback for *any* other monitor you plug in (extend, auto place/size)
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
