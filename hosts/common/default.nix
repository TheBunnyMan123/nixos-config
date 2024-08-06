{
  pkgs,
  inputs,
  createUser,
  ...
}: {
  imports = [
    ./containers.nix
    ./packages.nix
    ./services.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  qt = {
    enable = true;
    style = "kvantum";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      # ssh
      22
      
      # http(s)
      80
      443

      # Minecraft
      25565

      # SyncThing
      22000

      # SFTP Container
      2222
    ];

    allowedUDPPorts = [
      # Minecraft
      25565

      # SyncThing
      22000
      21027
    ];
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
