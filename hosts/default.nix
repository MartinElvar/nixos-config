{ lib, inputs, nixpkgs, home-manager, nur, user, location, nix-ld, ... }:

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
      nur.modules.nixos.default

      ./thinkpad
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user nur; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./thinkpad/home.nix)];
        };
      }
    ];
  };
}
