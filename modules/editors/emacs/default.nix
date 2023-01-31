{ config, pkgs, ... }:

{
  services.emacs = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
  };

  home = {
    # sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom.d";
      # DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "doom.d".source = ./doom.d;
    };
  };

  home.packages = with pkgs; [
    # DOOM Emacs dependencies
    binutils
    (ripgrep.override { withPCRE2 = true; })
    gnutls
    fd
    imagemagick
    zstd
    sqlite
    editorconfig-core-c
    emacs-all-the-icons-fonts
  ];
}
