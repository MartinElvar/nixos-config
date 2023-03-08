{
  description = "Martin Elvars personal configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      nur = {
        url = "github:nix-community/NUR";                                   # NUR Packages
      };

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      emacs-overlay = {                                                     # Emacs Overlays
        url = "github:nix-community/emacs-overlay";
        flake = false;
      };
   };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, ... }:
    let
      user = "saturn";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs self nixpkgs home-manager nur user location;   # Also inherit home-manager so it does not need to be defined here.
        }
      );
    };
}
