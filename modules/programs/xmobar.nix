{ pkgs, config, ... }:

{
  xdg = {
    configFile = {
      "xmobar".source = ./xmobar/xmobarrc.hs;
    };
  };
}
