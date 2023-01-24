{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/xmonad/default.nix)];# ++
    # [(import ../../modules/desktop/virtuallisation/docker/docker.nix)];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # initrd.kernelModules = [ "amdgpu" ];

    loader = {                                  # For legacy boot:
      systemd-boot = {
        enable = true;
        configurationLimit = 5;                 # Limit the amount of configurations
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;                              # Grub auto select time
    };
  };

  networking = {
    hostName = "Saturn-nixos";
    networkmanager.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.npm-packages
      color=true
    '';
  };

  services = {
    blueman.enable = true;
    logind = {
      lidSwitch = "hybrid-sleep";
      lidSwitchDocked = "ignore";
      extraConfig = ''
        HandlePowerKey=hybrid-sleep;
      '';
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      extraPlugins = with pkgs.postgresql_15.pkgs; [ postgis ];
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
      '';
    };
  };
}
