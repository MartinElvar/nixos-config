{ pkgs, ... }:

{
  imports = [
    # ../../modules/desktop/xmonad/home.nix
    ../../modules/desktop/hyprland/home.nix
  ];

  home = {
    file."wallpapers".source = ../wallpapers;

    packages = with pkgs; [
      blueman
      brightnessctl
      tlp
      # openvpn3
      # magic-wormhole

      # trezord
      # trezor-suite
      # trezor-udev-rules

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
      gnumake
      beamMinimal28Packages.erlang
      beamMinimal28Packages.elixir_1_18
      beamMinimal28Packages.elixir-ls
      vscode-langservers-extracted
      ghostscript
      devbox
      poppler_utils
      tesseract
      hoppscotch
      rustup
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
