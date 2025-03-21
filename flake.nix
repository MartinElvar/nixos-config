{
  description = "Martin Elvars personal configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-ld = {
        url = "github:Mic92/nix-ld";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixvim = {
          url = "github:nix-community/nixvim";
          # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
          inputs.nixpkgs.follows = "nixpkgs";
      };
      
      # Required, nvf works best and only directly supports flakes
      # nvf = {
      #   url = "github:notashelf/nvf";
      #   # You can override the input nixpkgs to follow your system's
      #   # instance of nixpkgs. This is safe to do as nvf does not depend
      #   # on a binary cache.
      #   inputs.nixpkgs.follows = "nixpkgs";
      #   # Optionally, you can also override individual plugins
      #   # for example:
      #   # inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
      # };
    };

  outputs = inputs @ { self, nix-ld,  nixpkgs, home-manager, nixvim, ... }:
    let
      user = "saturn";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs self nixpkgs home-manager user location nix-ld nixvim;
        }
      );
    };
}
