{ config, lib, pkgs, ... }:

{
  imports = [
    ../../services/flameshot.nix
    ../../services/picom.nix
  ];

  xsession = {
    enable = true;
    windowManager = {
      xmonad = {
        enable = true;
        config = /etc/nixos/nixos-config/modules/desktop/xmonad/config/xmonad.hs;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [
          hpkgs.xmobar
          hpkgs.xmonad-contrib
          hpkgs.xmonad-extras
        ];
      };
    };
  };
}
