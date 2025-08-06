{
  pkgs,
  inputs,
  ...
}: let
  libbluray = pkgs.libbluray.override {
    withAACS = true;
    withBDplus = true;
  };
in {
  environment.systemPackages = with pkgs; [
    makemkv
    handbrake
    ladybird

    (callPackage ../../../packages/worldographer-2025.nix {})
    android-studio
    audacity

    teamspeak6-client

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
    hyprpaper
    timewall
    grimblast
    nwg-look
    xterm
    caffeine-ng
    vulkan-tools
    nautilus
    par2cmdline-turbo
    aseprite

    libreoffice-qt6

    pinta

    brightnessctl

    spotify
    keepassxc
    gimp
    obs-studio
    (pkgs.vlc.override { inherit libbluray; })
    libsForQt5.qtstyleplugin-kvantum
    easyeffects
    inkscape
    obsidian

    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    flatpak
    mono
    gparted
    wineWowPackages.stable
  ];
}
