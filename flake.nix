{
  description = "Flake for NixOS";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/default-linux";
    fok-quote.url = "github:fokohetman/fok-quote";
  };

  outputs = { self, catppuccin, nixpkgs, home-manager, fok-quote, ... } @inputs:
  let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;
  in rec {
    createUser = import ./createUser.nix;

    nixosModules = {
      bunny-sshworthy = import ./bunny-sshworthy.nix;
    };

    nixosConfigurations = {  
      Desktop = lib.nixosSystem {
        system = "x86_64-linux"; 
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {home-manager.users.bunny.imports = [catppuccin.homeManagerModules.catppuccin];}
          ./hosts/desktop
        ];

        specialArgs = let homeStateVersion = "23.05"; systemStateVersion = "23.05"; in {
          inherit inputs outputs createUser homeStateVersion systemStateVersion fok-quote;
        };
      };
    };
  };
}
