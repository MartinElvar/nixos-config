{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland; # Use stable nixpkgs version to fix Qt version mismatch
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    swayosd
    ripgrep
    jq
    gnumake
    wget
    unzip
    curl
    kanshi
    wl-clipboard
    uwsm

    hyprshot
    hyprpicker
    brightnessctl
    pamixer
    playerctl
    gnome-themes-extra
    pavucontrol
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Initial login experience
  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd hyprland";
    settings.default_session.user = "saturn";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.caskaydia-mono
  ];
}
