{ pkgs, ... }:

{
  imports = [
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
      inotify-tools
      wxGTK32
      ncurses
      m4
      cmake
      gnumake
      beamMinimal28Packages.erlang
      beamMinimal28Packages.elixir_1_18
      beamMinimal28Packages.elixir-ls
      ghostscript
      poppler_utils
      tesseract
      hoppscotch
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
