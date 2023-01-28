{ config, lib, pkgs, inputs, user, location, ... }:

{
  imports =
    # [(import ../modules/editors/emacs/native.nix)] ++
    (import ../modules/shell);

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm"];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "da_DK.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security.rtkit.enable = true;
  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  fonts.fonts = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [           # Default packages install system-wide
      vim
      emacs
      ripgrep
      coreutils
      fd
      git
      killall
      nano
      pciutils
      usbutils
      wget
      rsync
      usbutils
      pipewire
    ];
  };

  services = {
    pipewire = {                            # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    flatpak.enable = true;
    udisks2.enable = true;
    autorandr.enable = true;
  };

  programs.ssh.startAgent = true;

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {                                # NixOS settings
    autoUpgrade = {                         # Allow auto update (not useful in flakes)
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}
