{ pkgs, nur, config, ... }:

{
  imports = [
    ../../modules/desktop/xmonad/home.nix
  ];

  home = {
    file."wallpapers".source = ./wallpapers;

    packages = with pkgs; [
      networkmanagerapplet
      blueman
      light
      tlp
      auto-cpufreq

      # Dev
      gnumake
      gcc
      fly
      nodejs-19_x
      sass
      inotify-tools
      postgresql_15
      erlangR25
      elixir_1_14
      elixir_ls
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
