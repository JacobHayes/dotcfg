{
  description = "jrh";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nix-darwin.follows = "darwin";
      inputs.nixpkgs.follows = "nixpkgs";
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
    {
      darwinConfigurations = {
        jrh = darwin.lib.darwinSystem {
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
          specialArgs = { inherit inputs; };
        };
      };
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
