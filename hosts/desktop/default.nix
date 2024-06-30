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

    ../common
    ../common/gaming
    ../common/gui
    ./hardware-configuration.nix
    ./packages.nix
  ];
  specialArgs = {inherit createUser;};

  system.stateVersion = "23.05";
}
