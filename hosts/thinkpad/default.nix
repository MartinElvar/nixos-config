{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/xmonad/default.nix)] ++
    [(import ../../modules/desktop/virtualisation/docker.nix)];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
    
    initrd.kernelModules = [ "amdgpu" ];

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
    networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };

  };

  hardware = {
    acpilight.enable = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  programs.nix-ld.enable = true;

  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.npm-packages
      color=true
    '';
  };

  programs.openvpn3.enable = true;

  services = {
    blueman.enable = true;
    logind = {
      lidSwitch = "hybrid-sleep";
      lidSwitchDocked = "ignore";
      extraConfig = ''
        IdleAction=ignore
        IdleActionSec=120min
        HandlePowerKey=hybrid-sleep
      '';
    };

    # Development.
    postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      extraPlugins = with pkgs.postgresql_15.pkgs; [ postgis timescaledb ];
      settings.shared_preload_libraries = "timescaledb";
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
      '';
    };

    grafana = {
      enable = true;
      settings.server = {
        http_port = 3005;
        http_addr = "127.0.0.1";
        domain = "localhost";
      };
    };

    udev.packages = with pkgs; [ 
      ledger-udev-rules
      trezor-udev-rules
      # potentially even more if you need them
    ];  
  };
}
