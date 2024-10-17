{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./containers.nix
    ./packages.nix
    ./services.nix
    ./users.nix
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persistent" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      {directory = "/etc/nixos"; mode = "0777";}
    ];
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  qt = {
    enable = true;
    style = "kvantum";
  };

  boot.kernel.sysctl = { "vm.swappiness" = 5; };

  networking = {
    wireless = {
      enable = true;
      networks = {
        "Nacho WiFi" = {
          pskRaw = "68ab5f9da6b1f9483e4ab7cd0bfc56359d733ef32d735a9b11140aac9985e327";
        };
      };
    };

    nameservers = ["1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" "100.100.100.100"];
    search = ["kamori-ghoul.ts.net" "int.tkbunny.net"];

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wlp4s0";
      enableIPv6 = true;
    };

    hosts = {
      "100.93.17.11" = [ "server.int.tkbunny.net" ];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [
        # ssh
        22
      
        # http(s)
        80
        443

        # SyncThing
        22000

        # SFTP Container
        2222
      ];

      allowedUDPPorts = [
        # SyncThing
        22000
        21027
      ];
    };
  };


  home-manager.backupFileExtension = ".home-manager.bak";

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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
}
