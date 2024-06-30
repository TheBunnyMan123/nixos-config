{
  description = "Flake for NixOS";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nathan.url = "github:poollovernathan/nixos";
    hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = { self, nixpkgs, home-manager, systems, hardware, nathan, ... } @inputs:
  let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in rec {
    createUser = import ./createUser.nix;

    nixosModules = {
      bunny-sshworthy = createUser {
        name = "bunny";
        hashedPassword = "$y$j9T$2fn61ZNkFqA9SC..wecPl/$mB/FcaC8bt04pMYQJy8GFXXF/wmt1Z7OWmjetmDP4B6";
        shell = pkgs: pkgs.zsh;
        systemUser = false;
        uid = 26897;
        description = "TheKillerBunny / TheBunnyMan123";

        packages = pkgs: with pkgs; [
          zsh
          coreutils-full
          (callPackage ./packages/icat.nix { })
          (callPackage ./packages/asciidots.nix { })
          git
          ffmpeg
          fastfetch
          github-cli
          tmux
          neovim
          zoxide
          fzf
          stow
          eza
          bat
          w3m
          jdk21
        ];
      };
    };

    nixosConfigurations = {  
      Desktop = lib.nixosSystem {
        system = "x86_64-linux"; 
        modules = [
          ./hosts/desktop
          nathan.nixosModules.nathan
        ];

        specialArgs = {
          inherit inputs outputs createUser;
        };
      };
    };
  };
}
