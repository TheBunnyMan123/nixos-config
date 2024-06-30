{
  pkgs,
  inputs,
  createUser,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ../common {inherit createUser;}
    ../common/gaming
    ../common/gui
    ./hardware-configuration.nix
    ./packages.nix
  ];

  system.stateVersion = "23.05";
}
