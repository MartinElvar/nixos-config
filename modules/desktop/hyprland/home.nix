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
    ./hyprpanel.nix
    ./mako.nix
    ./wofi.nix
    ./kanshi.nix
  ];

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  wayland.windowManager.hyprland.settings = {
    # Default applications
    "$terminal" = "alacritty";
    "$fileManager" = "nautilus --new-window";
    "$browser" = "brave --new-window --ozone-platform=wayland";
    "$music" = "spotify";
    "$messenger" = "signal-desktop";
    "$webapp" = "$browser --app";

    #monitor = "eDP-1,1920x1080@60.03,0x0,1.0";
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
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
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
