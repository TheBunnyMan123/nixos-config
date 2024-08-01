{ lib, ... }: {
  imports = [
    ./bunny.nix
  ];

  users.users.bunny.uid = lib.mkForce 26897;
}
