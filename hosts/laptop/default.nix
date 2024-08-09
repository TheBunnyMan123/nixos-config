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

  home-manager.users.bunny.wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,2256x1504@60.00Hz,0x0,1.33333"
      #"eDP-1,1920x1200@60.00Hz,0x0,1"
    ];
  };

  services.fwupd.enable = true;
  networking.hostName = "NixOS-Laptop";
  
  system.stateVersion = systemStateVersion;
}
