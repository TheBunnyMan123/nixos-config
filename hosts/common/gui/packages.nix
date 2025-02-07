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
    mono5
    gparted
    wineWowPackages.stable
  ];
}
