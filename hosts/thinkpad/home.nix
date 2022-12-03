{ pkgs, ... }:

{
  imports = [
    ../../modules/desktop/xmonad/home.nix
  ];

  home = {
    packages = with pkgs; [
      blueman
      light
      tlp
      auto-cpufreq
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
  }
}
