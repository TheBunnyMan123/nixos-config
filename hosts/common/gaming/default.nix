{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
  ];
}
