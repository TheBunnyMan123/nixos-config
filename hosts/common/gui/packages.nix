{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
    networkmanagerapplet
    flameshot
    wofi

    (callPackage ../../../packages/calculator.nix { })
    (callPackage ../../../packages/timer.nix { })
    (callPackage ../../../packages/turbowarp-appimage.nix { })
    spotify
    firefox-devedition-bin
    keepassxc
    gimp
    obs-studio
    vlc
    vesktop

    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    wineWowPackages.stable
  ];
}
