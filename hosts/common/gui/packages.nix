{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    flameshot
    rofi-wayland
    waybar
    swaynotificationcenter
    grim
    slurp
    clipse
    wl-clipboard
    hypridle
    grimblast
    nwg-look
    xterm

    (callPackage ../../../packages/calculator.nix { })
    (callPackage ../../../packages/timer.nix { })
    (callPackage ../../../packages/turbowarp-appimage.nix { })
    spotify
    firefox-devedition-bin
    keepassxc
    gimp
    obs-studio
    vlc
    libsForQt5.qtstyleplugin-kvantum
    easyeffects

    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    wineWowPackages.stable
  ];
}
