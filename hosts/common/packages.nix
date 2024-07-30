{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    (callPackage ../../packages/icat.nix { })
    (callPackage ../../packages/asciidots.nix { })
    (callPackage ../../packages/power.nix { })
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
    kanata
    bluetuith
  ];

  programs.gnupg = {
    package = pkgs.gnupg;

    agent.enable = true;
  };

  programs.zsh.enable = true;
}
