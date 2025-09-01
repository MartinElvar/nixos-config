{
  pkgs,
  inputs,
  user,
  ...
}:

{
  imports = (import ../modules/shell);

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "kvm"
    ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.i3lock.enable = true;

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
  fonts.packages = with pkgs; [
    # Fonts
    carlito # NixOS
    vegur # NixOS

    dejavu_fonts
    freefont_ttf
    gyre-fonts # TrueType substitutes for standard PostScript fonts
    liberation_ttf
    unifont
    noto-fonts-emoji
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    nerd-fonts.fira-code
    noto-fonts-emoji
    noto-fonts-cjk-sans
    symbola
    material-icons
  ];

  # Blox uses deprecated PEAP, downgrade openssl with this patch.
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.packageOverrides = pkgs: rec {
    wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
      patches = [ ./bloxhub.patch ];
    });
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages =
      with pkgs;
      let
        my-nvim = inputs.nvim.packages.${system}.default;
      in
      [
        # Default packages install system-wide
        nix-index
        vim
        my-nvim
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
        xclip
        gcc
        autorandr
        fprintd
      ];
  };

  services = {
    pipewire = {
      # Sound
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

    udev.enable = true;
    udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

    # Printer
    printing.browsing = true;
    printing.browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All

      BrowseProtocols all
    '';
  };

  # programs.ssh.startAgent = true;
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nix = {
    # Nix Package Manager settings
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      trusted-users = [
        "root"
        "saturn"
      ];
    };
    # gc = {
    #   # Automatic garbage collection
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 2d";
    # };
    package = pkgs.nixVersions.latest; # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    # NixOS settings
    autoUpgrade = {
      # Allow auto update (not useful in flakes)
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "23.05";
  };
}
