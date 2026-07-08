{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
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
    wl-mirror
    uwsm
    nwg-displays
    (writeShellScriptBin "hypr-mirror" (builtins.readFile ./scripts/toggle_mirror.sh))

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
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
    settings.default_session.user = "saturn";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-mono
  ];
}
