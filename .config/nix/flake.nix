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
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
  };

  outputs = inputs@{ self, darwin, home, nix-homebrew, nixpkgs, }: {
    # Build darwin flake using: `darwin-rebuild build --flake .#jrh`
    darwinConfigurations = {
      jrh = darwin.lib.darwinSystem { 
        modules = [
          ./darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          home.darwinModules.home-manager {
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
  };
}
