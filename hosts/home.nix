{
  pkgs,
  user,
  ...
}:

{
  imports =
    (import ../modules/editors) ++ (import ../modules/programs) ++ (import ../modules/services);

  home = {
    # username = "${user}";
    # homeDirectory = "/home/${user}";
    sessionPath = [
      "/home/saturn/.mix/escripts"
    ];

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
      ksnip

      # Apps
      brave
      firefox
      chromium
      slack
      spotify
      thunderbird
      discord
      obsidian
      libreoffice
      pinta
      signal-desktop
      helix
      kdePackages.filelight

      # File management
      unzip
      unrar
      kdePackages.okular
      nautilus
      sushi

      # General
      alacritty
      libnotify # Dunst dep
      rofi
      rofi-power-menu
      udiskie
      trayer
      kdePackages.kcalc
      networkmanagerapplet
      networkmanager-openvpn
      fzf
      clipse # clipboard manager
      eza # Better ls
      zoxide # Better cd
      fd # Better find

      # Xorg
      # xclip
      # xorg.xev
      # xorg.xkill
      # xorg.xrandr
      # arandr
      # xterm
      #
      (flameshot.override { enableWlrSupport = true; })

      caffeine-ng

      # Desktop
      ffmpeg
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

  services = {
    caffeine.enable = true;
  };
}
