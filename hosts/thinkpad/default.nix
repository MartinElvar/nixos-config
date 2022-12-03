{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware_configuration.nix)] ++
    [(import ../../modules/desktop/xmonad/default.nix)] ++
    [(import ../../modules/desktop/virtuallisation/docker/docker.nix)];

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

    services = {
      blueman.enable = true;
    };
  };
}
