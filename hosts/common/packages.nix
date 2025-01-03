{
  pkgs,
  inputs,
  system,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

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
    jdk21
    syncthing
    distrobox
    docker
    kanata
    bluetuith
    nodePackages.wrangler
    adguardhome
    nginx
    mutt
  ];

  programs.gnupg = {
    package = pkgs.gnupg;

    agent.enable = true;
  };

  programs.zsh.enable = true;
}
