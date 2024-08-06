{ pkgs, nur, config, ... }:

{
  imports = [
    ../../modules/desktop/xmonad/home.nix
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
      openvpn3
      # magic-wormhole

      udev

      trezord
      # trezor-suite 
      trezor-udev-rules
      
      linuxKernel.packages.linux_6_1.cpupower

      # Dev
      vscode
      zed-editor
      flyctl
      nodejs_20
      sass
      inotify-tools
      postgresql_15
      wxGTK32
      ncurses
      m4
      python311
      python311Packages.pip
      mosquitto
      cmake
      libgccjit
      gnumake
      gcc
      glibc
      erlang
      elixir
      elixir-ls
      vscode-langservers-extracted
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
