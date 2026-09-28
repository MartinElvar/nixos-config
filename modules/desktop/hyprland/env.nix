{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    # Environment variables
    env = [
      { _args = [ "GDK_SCALE" "1" ]; }

      # Cursor size
      { _args = [ "XCURSOR_SIZE" "24" ]; }
      { _args = [ "HYPRCURSOR_SIZE" "24" ]; }

      # Cursor theme
      { _args = [ "XCURSOR_THEME" "Adwaita" ]; }
      { _args = [ "HYPRCURSOR_THEME" "Adwaita" ]; }

      # Force all apps to use Wayland
      { _args = [ "GDK_BACKEND" "wayland" ]; }
      { _args = [ "QT_QPA_PLATFORM" "wayland" ]; }
      { _args = [ "QT_STYLE_OVERRIDE" "kvantum" ]; }
      { _args = [ "SDL_VIDEODRIVER" "wayland" ]; }
      { _args = [ "MOZ_ENABLE_WAYLAND" "1" ]; }
      { _args = [ "ELECTRON_OZONE_PLATFORM_HINT" "wayland" ]; }
      { _args = [ "OZONE_PLATFORM" "wayland" ]; }

      # Make Chromium use XCompose and all Wayland
      {
        _args = [
          "CHROMIUM_FLAGS"
          ''"--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4"''
        ];
      }

      # Make .desktop files available for wofi
      {
        _args = [
          "XDG_DATA_DIRS"
          "$XDG_DATA_DIRS:$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share"
        ];
      }

      # Use XCompose file
      { _args = [ "XCOMPOSEFILE" "~/.XCompose" ]; }
      { _args = [ "EDITOR" "hx" ]; }

      # GTK theme
      { _args = [ "GTK_THEME" "Adwaita:dark" ]; }
    ];

    config = {
      xwayland = {
        force_zero_scaling = true;
      };

      # Don't show update on first launch
      ecosystem = {
        no_update_news = true;
      };
    };
  };
}
