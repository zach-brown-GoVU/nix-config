{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake .#VU-D4RW65L6QG
    darwinConfigurations."VU-D4RW65L6QG" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/shared.nix
        ./modules/vu.nix
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 6;
          system.primaryUser = "zacharyc.brown";
          nixpkgs.hostPlatform = "aarch64-darwin";
        }
      ];
    };
  };
}
