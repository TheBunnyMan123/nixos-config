{
  pkgs,
  inputs,
  systemStateVersion,
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

  system.stateVersion = systemStateVersion;
}
