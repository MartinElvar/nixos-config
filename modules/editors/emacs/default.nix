{ config, pkgs, doom-emacs, ... }:

{
  imports = [ doom-emacs.hmModule ];

  services.emacs = {
    enable = true;
    package = doom-emacs;
  };

  programs.emacs = {
    enable = true;
  };

  # home.file.".doom.d" = {
  #   source = ./doom.d
  #   recursive = true;
  #   onChange = readFile ./doom.d;
  # };

  home = {
    sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom.d";
      DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "doom.d".source = ./doom.d;
      # "doom-config/config.el".text = "…";
      # "doom-config/init.el".text = "…";
      # "doom-config/packages.el".text = "…";
      "emacs" = {
        source = builtins.fetchGit "https://github.com/hlissner/doom-emacs";
        onChange = "${pkgs.writeShellScript "doom-change" ''
          export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
          export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
          if [ ! -d "$DOOMLOCALDIR" ]; then
            ${config.xdg.configHome}/emacs/bin/doom -y install
          else
            ${config.xdg.configHome}/emacs/bin/doom -y sync -u
          fi
        ''}";
      };
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
