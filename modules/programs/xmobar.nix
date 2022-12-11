{ pkgs, ... }:

{
  programs = {
    xmobar = {
      enable = true;
      extraConfig = ./xmobar/.xmobarrc.hs;
    };
  };
}
