{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "mac";
        options = "caps:super";
      };

      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          scrollMethod = "twofinger";
          naturalScrolling = false;                # The correct way of scrolling
          accelProfile = "adaptive";              # Speed settings
          #accelSpeed = "-0.5";
          disableWhileTyping = true;
        };
      };

      displayManager = {                          # Display Manager
        lightdm = {
          enable = true;                          # Wallpaper and GTK theme
          background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          greeters = {
            gtk = {
              theme = {
                name = "Dracula";
                package = pkgs.dracula-theme;
              };
              cursorTheme = {
                name = "Dracula-cursors";
                package = pkgs.dracula-theme;
                size = 16;
              };
            };
          };
        };
      };

      windowManager= {
        xmonad = {
          enable = true;
        };
      };

      #Drivers for AMD GPU
      #videoDrivers = [                           # Video Settings
        #"amdgpu"
      #];

      displayManager.sessionCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --mode 1920x1080 --pos 0x0 --rotate normal
      '';
    };
  displayManager.defaultSession = "none+xmonad";            # none+xmonad-> no real display manager
  };


  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [       # Packages installed
    xmobar
    xclip
    xorg.xkill
    xorg.xrandr
    arandr
    autorandr
    xterm
    alacritty
  ];

  xdg.portal = {                                  # Required for flatpak with window managers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
