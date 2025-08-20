{ pkgs, nix-colors, ... }:

{
  imports = [
    ../../modules/desktop/xmonad/home.nix
    ../../modules/desktop/hyprland/home.nix
  ];

  home = {
    file."wallpapers".source = ./wallpapers;

    packages = with pkgs; [
      xorg.xbacklight
      blueman
      brightnessctl
      tlp
      thunderbird
      chromium
      discord
      ksnip
      # openvpn3
      # magic-wormhole

      udev
      # trezord
      # trezor-suite
      # trezor-udev-rules

      linuxKernel.packages.linux_6_1.cpupower

      # Dev
      vscode
      flyctl
      inotify-tools
      postgresql
      wxGTK32
      ncurses
      m4
      python311
      python311Packages.pip
      mosquitto
      cmake
      zellij
      # libgccjit
      gnumake
      beamMinimal28Packages.erlang
      beamMinimal28Packages.elixir_1_19
      beamMinimal28Packages.elixir-ls
      vscode-langservers-extracted
      ghostscript
      devbox
      poppler_utils
      tesseract
      hoppscotch
      rustup

      # CoCoach
      zoom-us
      redis
      ngrok
    ];
  };

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
    cbatticon = {
      enable = true;
      criticalLevelPercent = 10;
      lowLevelPercent = 20;
      iconType = null;
    };
  };
}
