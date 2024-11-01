{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wlr-randr
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
    caffeine-ng
    vulkan-tools
    nautilus
    par2cmdline-turbo

    brightnessctl

    (callPackage ../../../packages/calculator.nix { })
    (callPackage ../../../packages/timer.nix { })
    (callPackage ../../../packages/turbowarp-appimage.nix { })
    spotify
    keepassxc
    gimp
    obs-studio
    vlc
    libsForQt5.qtstyleplugin-kvantum
    easyeffects
    inkscape

    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono5
    gparted
    wineWowPackages.stable
  ];
}
