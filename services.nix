{ 
  config, 
  pkgs, 
  lib,
  ...
}:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  services.flatpak.enable = true;
  services.sshd.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  services.syncthing = {
    enable = true;
    user = "bunny";
    configDir = "/home/bunny/.config/syncthing";
  };

  services.avahi = {
    nssmdns4 = true;
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
  services.libinput = {
    enable = true;
    touchpad.middleEmulation = false;
  };
 
  services.cron = {
    enable = true;
    systemCronJobs = [
      ''0 15 * * 1,3,5,6   bunny   yt-dlp "https://twitch.tv/filian" --cookies-from-browser firefox --wait-for-video 20 -o "/home/bunny/Videos/filian/filian-%(timestamp)s.%(ext)s"''
    ];
  };

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
 
   # Disable wait online as it's causing trouble at rebuild
   # See: https://github.com/NixOS/nixpkgs/issues/180175
   systemd.services.NetworkManager-wait-online.enable = false;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.steam-hardware.enable = true;

  networking.nat.enable  = true;
  networking.nat.internalInterfaces  = ["ve-+"];
  networking.nat.externalInterface  = "wlp4s0";
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  containers.nathantailnet = {
    autoStart = true;
    privateNetwork = false;

    bindMounts = {
      "/hostshare" = {
        hostPath = "/containershare/nathantailnet";
        isReadOnly = false;
      };
    };
    
    config = {config, pkgs, lib, ...}: {
      users = {
        mutableUsers = false;

        users.bunny = {
          isNormalUser = true;
          home = "/home/bunny";
          extraGroups = [ "wheel" ];
          hashedPassword = "$6$qnBIWuhaDxEII3WZ$.c3vcTwTNXQ8gDPy0RNdm5IgQ5LGd3hYpSRaBs6Kjj6jhN5gD56hFAPnyRzTp8HW4/mTCD87NhsjfctS8C3Yt0";
        };
      };

      services.tailscale = {
        useRoutingFeatures = "both";
        enable = true;
        port = 41642;
      };
    };
  };
}
