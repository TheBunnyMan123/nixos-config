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
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    # CLI apps
    inetutils
    temurin-jre-bin-17
    busybox
    (callPackage ./packages/icat.nix { })
    vim
    nano
    git
    appimage-run
    yt-dlp
    ffmpeg
    neofetch
    headsetcontrol
    distrobox
    docker
    github-cli

    # Needed GUI apps
    keepassxc
    (callPackage ./packages/firefox.nix { })
    (callPackage ./packages/calculator.nix { })
    (callPackage ./packages/timer.nix { })
    cinnamon.nemo
    thunderbird
    gnome.gnome-remote-desktop
    spotify
    libreoffice
    tor-browser-bundle-bin

    # Terminal
    powerline-rs
    tilix

    # Code
    (callPackage ./packages/turbowarp-appimage.nix { })
    vscode
    (callPackage ./packages/tilp.nix { })
    dotnetCorePackages.sdk_6_0
    dotnetPackages.Nuget

    # GNOME stuff
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    pkgs.gnome3.gnome-tweaks
    gnome.gnome-themes-extra
    gnomeExtensions.headsetcontrol
    gnomeExtensions.removable-drive-menu
    sweet
    (callPackage ./packages/candy-icons.nix { })

    # Media
    gimp
    obs-studio
    vlc
    gnome-photos
    blender

    # Games
    prismlauncher
    ruffle
    superTux
    discord
    citra-canary
    steam

    # General Usefulness
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    home-manager
    wineWowPackages.stable
    winetricks
    
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
    (
      pkgs.makeDesktopItem {
        name = "code-fix";
        desktopName = "VS Code Wayland Fix";
        comment = "Code Editing. Redefined.";
        genericName = "Text Editor";
        exec = "code --use-gl=desktop %F";
        icon = "vscode";
        startupNotify = true;
        categories = [ "Utility" "TextEditor" "Development" "IDE" ];
        mimeTypes = [ "text/plain" "inode/directory" ];
        keywords = [ "vscode" ];
        actions.new-empty-window = {
          name = "New Empty Window";
          exec = "code --use-gl=desktop --new-window %F";
          icon = "vscode";
      };
      }
    )
  ];
  
  # Get rid of most default packages
  environment.gnome.excludePackages = with pkgs.gnome; [ 
    baobab 
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
