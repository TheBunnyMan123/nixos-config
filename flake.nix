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
      buildFirefoxAddon = lib.makeOverridable (
        {
          pkgs ? nixpkgs.legacyPackages."x86_64-linux" ,
          fetchFirefoxAddon ? pkgs.fetchFirefoxAddon,
          stdenv ? pkgs.stdenv,
          name,
          version,
          url,
          hash,
          fixedExtid ? null,
          ...
        }:
        let
          extid = if fixedExtid == null then "nixos@${name}" else fixedExtid;
        in stdenv.mkDerivation {
          inherit name version;

          src = fetchFirefoxAddon { inherit url hash name; fixedExtid = extid; };

          preferLocalBuild = true;
          allowSubstitutes = true;

          buildCommand = ''
            dist="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p "$dist"
            ls $src
            install -v -m644 "$src/${extid}.xpi" "$dist/${extid}.xpi"
          '';
        }
      );
    
    lib = nixpkgs.lib // home-manager.lib;
  in rec {
    createUser = import ./createUser.nix;

    nixosModules = {
      bunny = import ./bunny.nix;
      vencord = import ./modules/vencord.nix;
      inherit buildFirefoxAddon;
    };

    nixosConfigurations = {  
      Desktop = lib.nixosSystem rec {
        system = "x86_64-linux"; 
        modules = [
          inputs.nathan.nixosModules.nathan-nosudo
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          ./hosts/desktop
        ];

        specialArgs = let homeStateVersion = "23.05"; systemStateVersion = "23.05"; in {
          inherit inputs outputs createUser homeStateVersion systemStateVersion fok-quote system;
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
          inherit inputs outputs createUser homeStateVersion systemStateVersion fok-quote system;
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
          inherit inputs outputs createUser homeStateVersion systemStateVersion fok-quote system;
        };
      };
    };
  };
}
