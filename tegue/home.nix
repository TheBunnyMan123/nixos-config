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
    "org/gnome/shell/extensions/HeadsetControl" = {
      headsetcontrol-executable = "headsetcontrol";
      option-battery = "-b";
      option-capabilities = "-?";
      option-chatmix = "-m";
      option-inactive-time = "-i";
      option-led = "-l";
      option-rotate-mute = "-r";
      option-sidetone = "-s";
      option-voice = "-v";
      show-systemindicator = true;
      use-notifications = false;
      use-logging = true;
      use-colors = true;
      color-batteryhigh = "rgb(0,255,0)";
      color-batterymedium = "rgb(255,255,0)";
      color-batterylow = "rgb(255,0,0)";
    };
    "org/gnome/shell" = {
      disabled-extensions = ["workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com"];
      enabled-extensions = ["drive-menu@gnome-shell-extensions.gcampax.github.com" "HeadsetControl@lauinger-clan.de" "clipboard-indicator@tudmotu.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com"];
    };
  };
      
}