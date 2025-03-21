{ inputs, nixpkgs, home-manager, user, location, nixvim, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  thinkpad = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      ./thinkpad
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [
            nixvim.homeManagerModules.default
            (import ./home.nix)] ++ [(import ./thinkpad/home.nix)
          ];
        };
      }
    ];
  };
}
