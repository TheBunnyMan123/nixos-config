{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-clipman-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-screensaver
    networkmanagerapplet
    flameshot

    (callPackage ../../../packages/calculator.nix { })
    (callPackage ../../../packages/timer.nix { })
    (callPackage ../../../packages/turbowarp-appimage.nix { })
    spotify
    firefox-devedition-bin
    alacritty
    keepassxc
    gimp
    obs-studio
    vlc
    # vesktop (broken at time of commenting)

    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    wineWowPackages.stable
  ];
}
