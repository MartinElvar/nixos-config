{
  ...
}:
let
  wallpaper = "~/wallpapers/comfy_waves.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        wallpaper
      ];
      wallpaper = [
        ", ${wallpaper}"
      ];
    };
  };
}
