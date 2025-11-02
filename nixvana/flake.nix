{
  description = "nix-darwin config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@inputs:
  let
    system = "aarch64-darwin";
    user = "Srivatsavs-MacBook-Air";
  in {
    darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
      system = system;
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.srivatsavauswin = import ./home.nix;
        }
      ];
    };
  };
}
