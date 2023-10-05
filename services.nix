{ 
  config, 
  pkgs, 
  lib,
  ...
}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  services.flatpak.enable = true;
  
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  
  services.avahi = {
    nssmdns = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };



  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.xserver.libinput.enable = true;
  
  # Virtual Machines
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  
  # Bootloader.
  boot.loader = {
  efi = {
    canTouchEfiVariables = true;
#    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
  };
  grub = {
    enable = true;
    efiSupport = true;
#    efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
    device = "nodev"; #/dev/sda";

    theme = pkgs.stdenv.mkDerivation {
      pname = "xenlism-grub-themes";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "TheBunnyMan123";
        repo = "xenlism-grub-themes-nixos-only";
        rev = "v1.0";
        hash = "sha256-KE2sY7JhIjmHBfoMR1cqrulhKBTfKV6OohrFcHsxZ0Q";
      };
      installPhase = "cp -r xenlism-grub-1080p-nixos/Xenlism-Nixos/ $out";
    };
    extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
      menuentry "Exit" {
        exit
      }
    '';
  };
};

  networking.hostName = "NixOS"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  
  # Enable networking
  networking.networkmanager.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
