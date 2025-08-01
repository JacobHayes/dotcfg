{
  description = "jrh";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
  };

  outputs =
    inputs@{
      self,
      darwin,
      home,
      homebrew,
      nixpkgs,
    }:
    let
      mkDarwinConfig =
        hostname:
        darwin.lib.darwinSystem {
          modules = [
            ./darwin.nix
            home.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  jacobhayes = import ./home.nix;
                };
              };
            }
          ];
          specialArgs = { inherit inputs hostname; };
        };
    in
    {
      darwinConfigurations = {
        jrh = mkDarwinConfig "jrh";
        jrh-m4 = mkDarwinConfig "jrh-m4";
      };
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
