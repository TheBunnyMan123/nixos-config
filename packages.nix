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
    ruffle
    git-secrets
    nano
    nodejs
    virt-manager
    qemu_kvm
    vscode
    flatpak
    vlc
    mono5
    gnome-photos
    gnome.gnome-screenshot
    gnome.gnome-system-monitor
    gparted
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnome.gnome-themes-extra
    git
    appimage-run
    gnome.nautilus
    discord
    libvirt
    yt-dlp
    ffmpeg
    home-manager
    wget
    chromium
    curl
    nssmdns
    citra-canary
    steam
    pmutils
    p7zip
    thunderbird
    gnome.gnome-remote-desktop
    spotify
    hashcat
    pkgs.gnome3.gnome-tweaks
    libreoffice
    python311Full
    python311Packages.pip
    python311Packages.platformdirs
    python311Packages.pyqt6
    python311Packages.joblib
    python311Packages.setuptools
    samba4Full
    dotnetCorePackages.sdk_6_0
    headsetcontrol
    gnomeExtensions.headsetcontrol
    gnomeExtensions.removable-drive-menu
    distrobox
    gimp
    docker
    shotcut
    tor-browser-bundle-bin
    git-credential-manager
    github-cli
    browsh
    baobab
    wineWowPackages.stable
    winetricks
    dotnetPackages.Nuget
    anbox
    neofetch
    blender
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    obs-studio
    powerline-rs
    tilix

    # Local Packages
    (callPackage ./packages/tilp.nix { })
    (callPackage ./packages/icat.nix { })
    (callPackage ./packages/firefox.nix { })
    (callPackage ./packages/calculator.nix { })
    (callPackage ./packages/timer.nix { })
    (callPackage ./packages/nerdls.nix { })
    (callPackage ./packages/turbowarp-appimage.nix { })
    (
      pkgs.makeDesktopItem {
        name = "turbowarp";
        desktopName = "TurboWarp";
        exec = "TurboWarp";
        terminal = false;
      }
    )

    # Missing Desktop Icons
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
    yelp evince 
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
    geary 
    gnome-keyring
    gnome-software
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
