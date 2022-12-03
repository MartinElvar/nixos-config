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

      doom-emacs = {
        url = "github:nix-community/nix-doom-emacs";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.emacs-overlay.follows = "emacs-overlay";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, doom-emacs, ... }:
    let
      user = "saturn";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location doom-emacs;   # Also inherit home-manager so it does not need to be defined here.
        }
      );
    }
}
