{ pkgs, ... }:

{
  programs = {
    xmobar = {
      enabled = true;
      extraConfig = ./xmobar/.xmobarrc.hs;
    };
  };
}
