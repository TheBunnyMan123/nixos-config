
{ 
  config, 
  pkgs, 
  lib,
  wrapFirefox,
  fetchFirefoxAddon,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    #blockbench-electron
    gnome.zenity

    # CLI apps
    temurin-jre-bin-17
    busybox
    (callPackage ./packages/icat.nix { })
    git
    yt-dlp
    ffmpeg
    neofetch
    distrobox
    docker
    github-cli

    # Needed GUI apps
    keepassxc
    (callPackage ./packages/firefox.nix { })
    (callPackage ./packages/calculator.nix { })
    (callPackage ./packages/timer.nix { })
    cinnamon.nemo
    spotify

    # Terminal
    powerline-rs
    gnome-console

    # Code
    (callPackage ./packages/tilp.nix { })
    dotnetCorePackages.sdk_8_0
    dotnetPackages.Nuget

    # GNOME stuff
    pkgs.gnome3.gnome-tweaks
    sweet
    (callPackage ./packages/candy-icons.nix { })

    # Media
    gimp
    obs-studio
    vlc
    gnome-photos

    # Games
    discord
    steam
    prismlauncher

    # General Usefulness
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    home-manager
    wineWowPackages.stable
    (callPackage ./packages/nerdls.nix { })

    # Desktop Icons
    (
      pkgs.makeDesktopItem {
        name = "ruffle";
        desktopName = "Ruffle";
        exec = "ruffle_desktop";
        terminal = false;
      }
    )
    (
      pkgs.makeDesktopItem {
        name = "discord-fix";
        desktopName = "Discord Wayland Fix";
        exec = "Discord --use-gl=desktop";
        terminal = false;
        icon="discord";
        genericName = "All-in-one cross-platform voice and text chat for gamers";
        categories = [ "Network" "InstantMessaging" ];
        mimeTypes = [ "x-scheme-handler/discord" ];
      }
    )
  ];
  
  # Get rid of most default packages
  environment.gnome.excludePackages = with pkgs.gnome; [ 
    epiphany 
    simple-scan 
    totem
    pkgs.gnome-console
    yelp evince 
    gnome-screenshot
    gnome-calculator 
    gnome-calendar 
    gnome-characters 
    gnome-clocks 
    gnome-contacts 
    gnome-font-viewer 
    gnome-logs 
    gnome-maps 
    gnome-music 
    gnome-weather 
    gnome-disk-utility 
    pkgs.gnome-tour 
    cheese 
    nautilus
    gnome-system-monitor
    geary 
    gnome-keyring
    gnome-software
    nautilus
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = false;
  };

  programs.adb.enable = true;

  programs.git.config = {
    init = {
      defaultBranch = "main";
    };
    url = {
      "https://github.com/" = {
        insteadOf = [
          "gh:"
          "github:"
        ];
      };
      "https://gitlab.com/" = {
        insteadOf = [
          "gl:"
          "gitlab:"
        ];
      };
    };
    safe = {
      directory = "/etc/nixos";
    };
    user = {
      email = "bunnymcnair@gmail.com";
    	name = "Tegue";
    };
  };

    programs.chromium = {
    enable = true;
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-US"
      ];
      "HttpsOnlyMode" = "force_enabled";
    };
    extensions = [
      "dapfmaempgppekcneleonmpoebhkfaol" # https somewhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
    ];
  };
}
