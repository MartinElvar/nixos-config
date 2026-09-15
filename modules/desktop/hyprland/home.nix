{
  pkgs,
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
  wayland.windowManager.hyprland.configType = "hyprlang";

  # uwsm owns the session targets (programs.hyprland.withUWSM). home-manager's
  # hyprland-session.target now sets PropagatesStopTo=graphical-session.target,
  # so its startup `systemctl --user stop hyprland-session.target` tears down
  # graphical-session.target and kills the compositor a second after login.
  wayland.windowManager.hyprland.systemd.enable = false;

  wayland.windowManager.hyprland.settings = {
    # nwg-displays writes monitor layout here; Hyprland auto-reloads it on change
    source = [ "~/.config/hypr/monitors.conf" ];

    # Default applications
    "$terminal" = "alacritty";
    "$fileManager" = "nautilus --new-window";
    "$browser" = "brave --new-window --ozone-platform=wayland";
    "$music" = "spotify";
    "$messenger" = "signal-desktop";
    "$webapp" = "$browser --app";

    monitor = [
      # Always set up the laptop panel
      # "eDP-1, preferred, 0x0, 1"
      # Fallback for *any* other monitor you plug in (extend, auto place/size)
      ", preferred, auto, 1"
    ];
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
