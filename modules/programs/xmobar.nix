{ pkgs, ... }:

{
  programs = {
    xmobar = {
      enable = true;
      extraConfig = (builtins.readFile ./xmobar/xmobarrc.hs);
    };
  };
}
