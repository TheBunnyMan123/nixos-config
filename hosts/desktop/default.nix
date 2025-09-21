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
    inputs.hardware.nixosModules.common-pc-ssd

    ../common
    # ../common/virtualization.nix
    ../common/gaming
    ../common/gui
    ./hardware-configuration.nix
    ./packages.nix
  ];

  networking.hostName = "NixOS-Desktop";
  
  home-manager.users.bunny.wayland.windowManager.hyprland = {
    extraConfig = ''
      env = XDG_SESSION_TYPE,wayland

      cursor {
        no_hardware_cursors = true
      }
    '';
    settings = {
      monitor = [
        "DP-1,1920x1080@143.86Hz,0x0,1"
      ];
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "bunny";
  };

  system.stateVersion = systemStateVersion;
}
