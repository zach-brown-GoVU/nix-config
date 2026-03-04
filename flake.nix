{
  description = "Nix configuration for macOS machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      systems = {
        work = {
          hostname = "VU-D4RW65L6QG";
          system = "aarch64-darwin";
          username = "zacharyc.brown";
        };
        personal = {
          hostname = "Zachs-MacBook-Pro";
          system = "aarch64-darwin";
          username = "zachbrown";
        };
      };

      mkDarwinConfiguration = { hostname, system, username }: nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [
          ./hosts/${nixpkgs.lib.toLower hostname}
        ];
      };

      mkHomeConfiguration = { system, username, hostname ? null }: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs username; };
        modules = [
          ./home/${username}
        ];
      };
    in
    {
      darwinConfigurations = {
        "VU-D4RW65L6QG" = mkDarwinConfiguration systems.work;
        "Zachs-MacBook-Pro" = mkDarwinConfiguration systems.personal;
      };

      homeConfigurations = {
        "zacharyc.brown" = mkHomeConfiguration systems.work;
        "zachbrown" = mkHomeConfiguration systems.personal;
      };
    };
}
