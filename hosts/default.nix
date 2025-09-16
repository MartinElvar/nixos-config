{
  inputs,
  nixpkgs,
  overlays,
  home-manager,
  nix-colors,
  user,
  location,
  ...
}:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system overlays;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  thinkpad = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        user
        location
        nix-colors
        ;
    };
    modules = [
      ./thinkpad
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        nixpkgs.overlays = overlays;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user inputs nix-colors; };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
            ./thinkpad/home.nix
          ];
        };
      }
    ];
  };

  framework = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        user
        location
        nix-colors
        ;
    };
    modules = [
      ./framework
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        nixpkgs.overlays = overlays;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user inputs nix-colors; };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
            ./framework/home.nix
          ];
        };
      }
    ];
  };
}
