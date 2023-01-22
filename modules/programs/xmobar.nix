{ pkgs, ... }:

{
  xdg = {
    configFile = {
      "xmobar".source = ./xmobar;
    };
  };
}
