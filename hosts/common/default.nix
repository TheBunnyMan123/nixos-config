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

  services.resolved = {
    enable = false;
  };
  services.adguardhome = {
    enable = true;
    settings = {
      http = {
        address = "127.0.0.1:3000";
      };
      http_proxy = "127.0.0.1:80";
      auth_attempts = 3;
      dns = {
        bind_hosts = [
          "127.0.0.1"
          "::1"
        ];

        upstream_dns = ["1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4"];
        bootstrap_dns = ["1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4"];
      };
      filtering = {
        rewrites = [
          {
            domain = "adguard.int.tkbunny.net";
            answer = "127.0.0.9";
          }
        ];
      };
      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_10.txt";
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt";
        }
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_12.txt";
        }
      ];
    };
    mutableSettings = false;
  };

  boot.kernel.sysctl = { "vm.swappiness" = 5; };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."adguard.int.tkbunny.net" = {
      listen = [
        {
          addr = "127.0.0.9";
          port = 80;
        }
      ];

      locations."/" = {
        proxyPass = "http://127.0.0.2:3000";
        extraConfig = ''
          proxy_pass_header Authorization;
        '';
      };
    };
  };

  networking = {
    wireless = {
      enable = true;
      networks = {
        "Nacho WiFi" = {
          pskRaw = "68ab5f9da6b1f9483e4ab7cd0bfc56359d733ef32d735a9b11140aac9985e327";
        };
      };
    };

    nameservers = ["127.0.0.1"];
    search = ["kamori-ghoul.ts.net" "int.tkbunny.net"];

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wlp4s0";
      enableIPv6 = true;
    };

#    extraHosts = ''
#      127.0.0.2:3000 adguard.int.tkbunny.net
#    '';

    firewall = {
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
