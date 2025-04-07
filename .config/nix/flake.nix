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
      inputs.nix-darwin.follows = "darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jujutsu = {
      url = "git+https://github.com/jj-vcs/jj?ref=refs/tags/v0.28.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      darwin,
      home,
      homebrew,
      jujutsu,
      nixpkgs,
    }:
    let
      mkDarwinConfig =
        hostname:
        darwin.lib.darwinSystem {
          modules = [
            {
              nixpkgs.overlays = [
                inputs.jujutsu.overlays.default
              ];
            }
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
