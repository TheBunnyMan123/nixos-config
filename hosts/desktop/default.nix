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

  networking.hostName = "NixOS-Desktop";
  
  home-manager.users.bunny.wayland.windowManager.hyprland.extraConfig = ''
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia

    cursor {
      no_hardware_cursors = true
    }
  '';

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "bunny";
  };

  system.stateVersion = systemStateVersion;
}
