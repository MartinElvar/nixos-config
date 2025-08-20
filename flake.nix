{
  description = "Martin Elvars personal configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "path:./lazyvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-ld,
      nix-colors,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      user = "saturn";
      location = "$HOME/.setup";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit
            inputs
            self
            nixpkgs
            home-manager
            nix-colors
            user
            location
            nix-ld
            ;
        }
      );
    };
}
