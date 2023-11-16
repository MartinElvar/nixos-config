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
      auto-cpufreq
      thunderbird
      chromium
      openvpn3
      magic-wormhole

      linuxKernel.packages.linux_6_1.cpupower

      # Dev
      vscode
      gnumake
      gcc
      glibc
      flyctl
      nodejs_20
      sass
      inotify-tools
      postgresql_15
      wxGTK32
      ncurses
      m4
      jdk20
      python311
      python311Packages.pip
      mosquitto
      influxdb2
      cmake
      libgccjit
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
