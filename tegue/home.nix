{pkgs, ...}:

{
  # The home.stateVersion option does not have a default and must be set
  home.username = "bunny";
  home.homeDirectory = "/home/bunny";
  home.stateVersion = "23.05"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
      
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/notifications" = {
      show-banners = true;
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/search-providers" = {
      disable-external = false;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///etc/nixos/NixOS_1440p.png";
      picture-uri-dark = "file:///etc/nixos/NixOS_1440p.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = 0;
    };
    "org/gnome/desktop/session" = {
      idle-delay = 300;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };
  };
      
}