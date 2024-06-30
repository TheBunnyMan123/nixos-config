{
  pkgs,
  inputs,
  createUser,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
    ./users.nix {inherit createUser;}
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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
}
