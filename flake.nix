{
  description = "Flake for NixOS";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, home-manager }: {
    
    nixosConfigurations = {  
      NixOS-Desktop = nixpkgs.lib.nixosSystem {
          
        system = "x86_64-linux"; 
        modules = [
          ./configuration.nix
          ./host-specific/desktop/hardware-configuration.nix
          ./host-specific/desktop/stateVersion.nix
          ./services.nix
          ./packages.nix
          ./host-specific/nvidia-drivers.nix

          # User Specific
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bunny = import ./bunny/home.nix;
          }

        ];
      };

      NixOS-Laptop = nixpkgs.lib.nixosSystem {
          
        system = "x86_64-linux"; 
        modules = [
          ./configuration.nix
          ./host-specific/laptop/hardware-configuration.nix
          ./host-specific/laptop/stateVersion.nix
          ./services.nix
          ./packages.nix
          
          # User Specific
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bunny = import ./bunny/home.nix;
          }

        ];
      };
    };
  };
}