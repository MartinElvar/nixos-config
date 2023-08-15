{ pkgs, nur, config, ... }:

{
  imports = [
    ../../modules/desktop/xmonad/home.nix
  ];

  home = {
    file."wallpapers".source = ./wallpapers;

    packages = with pkgs; ([
      xorg.xbacklight
      blueman
      brightnessctl
      tlp
      auto-cpufreq
      thunderbird
      chromium
      magic-wormhole

      linuxKernel.packages.linux_6_1.cpupower

      # Dev
      gnumake
      gcc
      glibc
      flyctl
      nodejs_20
      sass
      inotify-tools
      postgresql_15
      elixir_1_15
      wxGTK32
      ncurses
      m4

      # beam.packages.erlang_26.elixir_1_15
      # beam.packages.erlang_26.rebar3
      nodePackages.typescript-language-server
      # elixir_1_15
      # elixir-ls
      mosquitto
      influxdb2
      cmake
      libgccjit
    ]) ++ (
      let 
        beamPkg = beam.packagesWith erlang_26;

        elixir_ls = beamPkg.elixir-ls.override {
          elixir = beamPkg.elixir_1_15;
            # erlang = erlang_26;
          mixRelease = beamPkg.mixRelease.override { 
            elixir = elixir_1_15; 
          };    
        };
      in
      [
        elixir_ls
      ]);
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
