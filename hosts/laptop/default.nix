{
  pkgs,
  inputs,
  systemStateVersion,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd

    ../common
    ../common/gui
    ./hardware-configuration.nix
    ./packages.nix
  ];

  services.fwupd.enable = true;
  networking.hostName = "NixOS-Laptop";
  
  system.stateVersion = systemStateVersion;
}
