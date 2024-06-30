{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    (callPackage ../../packages/icat.nix { })
    (callPackage ../../packages/asciidots.nix { })
    coreutils-full
    git
    fastfetch
    github-cli
    neovim
    fzf
    eza
    bat
    w3m
    jdk21
    syncthing
    distrobox
    docker
  ];

  programs.gnupg = {
    package = pkgs.gnupg;

    agent.enable = true;
  };
}
