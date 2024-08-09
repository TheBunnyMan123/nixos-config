{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
  ];
}
