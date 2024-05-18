
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
    # XFCE Plugins
    xfce.thunar
    xfce.thunar-volman
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-clipman-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-screensaver
    networkmanagerapplet
    flameshot

    # CLI apps
    zsh
    busybox
    (callPackage ./packages/icat.nix { })
    git
    yt-dlp
    ffmpeg
    fastfetch
    distrobox
    docker
    github-cli
    tmux neovim zoxide fzf stow eza bat w3m alacritty keepassxc syncthing

    # Needed GUI apps
    keepassxc
    firefox-devedition-bin
    (callPackage ./packages/calculator.nix { })
    (callPackage ./packages/timer.nix { })
    spotify
    discord

    # Media
    gimp
    obs-studio
    vlc

    # Games
    steam

    # General Usefulness
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    home-manager
    wineWowPackages.stable
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

  programs.gnupg = {
    package = pkgs.gnupg;

    agent.enable = true;
  };
}
