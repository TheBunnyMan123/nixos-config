{
  description = "Flake for NixOS";
  
  inputs = rec {
    figmanager.url = "github:Figura-Goofballs/FigManager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/default-linux";
    fok-quote.url = "github:fokohetman/fok-quote";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixos-utils = {
      url = "github:TheBunnyMan123/NixosUtils";
      inputs = {
         nixpkgs.follows = "nixpkgs";
         home-manager.follows = "home-manager";
      };
    };
    nathan = {
       url = "github:PoolloverNathan/nixos";
       inputs = {
         nixpkgs.follows = "nixpkgs";
         catppuccin.follows = "catppuccin";
         fokquote.follows = "fok-quote";
         home-manager.follows = "home-manager";
       };
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, catppuccin, nixpkgs, home-manager, fok-quote, nur, impermanence, ... } @inputs:
  let
    inherit (self) outputs;
    inherit catppuccin;
    lib = nixpkgs.lib // home-manager.lib;
  in {
    nixosModules = {
      mkBunny = import ./bunny.nix;
      vencord = import ./modules/vencord.nix;
    };

    nixosConfigurations = {  
      Desktop = lib.nixosSystem rec {
        system = "x86_64-linux"; 
        modules = [
          # (inputs.nathan.mkNathan { canSudo = false; large = false; })
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          ./hosts/desktop
        ];

        specialArgs = let homeStateVersion = "23.05"; systemStateVersion = "23.05"; in {
          inherit (inputs.nixos-utils.nixosModules."x86_64-linux") createUser buildFirefoxAddon;
          inherit inputs outputs homeStateVersion systemStateVersion fok-quote system;
        };
      };
      Laptop = lib.nixosSystem rec {
        system = "x86_64-linux"; 
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          ./hosts/laptop
        ];

        specialArgs = let homeStateVersion = "23.05"; systemStateVersion = "23.05"; in {
          inherit (inputs.nixos-utils.nixosModules."x86_64-linux") createUser buildFirefoxAddon;
          inherit inputs outputs homeStateVersion systemStateVersion fok-quote system;
        };
      };
      Server = lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          ./hosts/server
        ];

        specialArgs = let homeStateVersion = "24.05"; systemStateVersion = "24.05"; in {
          inherit (inputs.nixos-utils.nixosModules."x86_64-linux") createUser buildFirefoxAddon;
          inherit inputs outputs homeStateVersion systemStateVersion fok-quote system;
        };
      };
    };
  };
}
