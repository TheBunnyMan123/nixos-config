{ 
  inputs,
  pkgs,
  ...
}:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  services.printing.enable = true;
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;
  };
  services.libinput = {
    enable = true;
    touchpad.middleEmulation = false;
  };

  networking.hostName = "NixOS-Desktop";
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  # Disable wait online as it's causing trouble at rebuild
  # See: https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.steam-hardware.enable = true;
}
