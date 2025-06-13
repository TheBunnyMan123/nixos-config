{
  pkgs,
  inputs,
  system,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    wrangler = pkgs.wrangler.overrideAttrs {
      dontCheckForBrokenSymlinks = true; # Temporary fix for nixpkgs#381980
    };
  };
  
  environment.systemPackages = with pkgs; [
    inputs.figmanager.packages."${system}".default
    (callPackage ../../packages/icat.nix      { })
    (callPackage ../../packages/asciidots.nix { })
    (callPackage ../../packages/power.nix     { })
    (callPackage ../../packages/nixos.nix     { })
    (callPackage ../../packages/page.nix      { })
    coreutils-full
    git
    fastfetch
    github-cli
    neovim
    fzf
    eza
    rcs
    bat
    w3m
    (jdk23.override {enableJavaFX = true;})
    syncthing
    distrobox
    docker
    kanata
    bluetuith
    nodePackages.wrangler
    adguardhome
    nginx
    mutt
    acpi

    cargo
    rustc
  ];

  programs.gnupg = {
    package = pkgs.gnupg;

    agent.enable = true;
  };

  programs.zsh.enable = true;
}
