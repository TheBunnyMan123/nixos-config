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
    ../common/server
    ./hardware-configuration.nix
    ./packages.nix
  ];

  hardware.nvidia.open = true;

  networking.hostName = "NixOS-Desktop";
  
  home-manager.users.bunny.wayland.windowManager.hyprland = {
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia

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
