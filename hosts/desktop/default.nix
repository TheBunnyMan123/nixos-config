{
  pkgs,
  inputs,
  createUser,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.hardware.nixosModules.common-pc-ssd

    ../common
    ../common/gaming
    ../common/gui
    ./hardware-configuration.nix
    ./packages.nix
  ];

  home-manager.users.root.home.stateVersion = "23.05";
  home-manager.users.bunny.home.stateVersion = "23.05";
  system.stateVersion = "23.05";
}
