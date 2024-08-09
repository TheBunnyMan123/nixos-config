{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
    ./gaming-home.nix
  ];
}
