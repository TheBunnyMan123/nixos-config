{
  pkgs,
  inputs,
  systemStateVersion,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-laptop-ssd

    ../common
    ../common/server
    ./hardware-configuration.nix
  ];

  networking.hostName = "NixOS-Server";

  system.stateVersion = systemStateVersion;
}
