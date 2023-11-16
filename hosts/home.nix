{ config, lib, pkgs, user, fetchpatch, ... }:

{
  imports =
    (import ../modules/editors) ++
    (import ../modules/programs) ++
    (import ../modules/services);


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      cacert
      dconf
      keychain

      # Terminal
      btop
      pfetch
      ranger
      tldr

      # Video/Audio
      feh
      mpv
      pavucontrol
      vlc
      pnmixer

      # Apps
      brave
      firefox
      slack
      spotify
      libreoffice

      # File management
      unzip
      unrar
      okular
      gnome.nautilus
      gnome.sushi

      # General
      alacritty
      dunst
      libnotify # Dunst dep
      rofi
      rofi-power-menu
      udiskie
      trayer
      kcalc
      networkmanagerapplet
      networkmanager-openvpn

      # Xorg
      xclip
      xorg.xev
      xorg.xkill
      xorg.xrandr
      autorandr
      arandr
      xterm

      flameshot
      caffeine-ng

      # Desktop
      ffmpeg

      # Haskell
      stack
      cabal-install
      stylish-haskell
      haskellPackages.hoogle
      haskellPackages.ghcide
      haskellPackages.gtk2hs-buildtools
    ];

    pointerCursor = {
      #name = "Dracula-cursors";
      name = "Catppuccin-Mocha-Dark-Cursors";
      #package = pkgs.dracula-theme;
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
    autorandr.enable = true;
  };

  services.betterlockscreen.enable = true;
  services.caffeine.enable = true;

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Dracula";
      #name = "Catppuccin-Dark";
      package = pkgs.dracula-theme;
      #package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
    };                                        # Cursor is declared under home.pointerCursor
  };
}
