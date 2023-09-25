{pkgs, ...}:

{
  # The home.stateVersion option does not have a default and must be set
  home.username = "bunny";
  home.homeDirectory = "/home/bunny";
  home.stateVersion = "23.05"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
      
  dconf.settings = {
    "org/gnome/mutter" = {
      edge-tiling = true;
      overlay-key = "Super_L";
      attach-modal-dialogs = false;
      center-new-windows = false;
    };
    "org/gnome/input-sources" = {
      show-all-sources = false;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };
    "org/gnome/desktop/wm/prefrences" = {
      action-double-click-titlebar = "toggle-maximize";
      action-middle-click-titlebar = "minimize";
      action-right-click-titlebar = "menu";
      button-layout = "appmenu:close";
      titlebar-font = "Noto Sans Semi-Bold 11";
      resize-with-right-button = false;
      mouse-button-modifier = "<Super>";
      focus-mode = "click";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
      click-method = "fingers";
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "adaptive";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
      gtk-enable-primary-paste = false;
      locate-pointer = true;
      gtk-key-theme = "Default";
      document-font-name = "Noto Sans 11";
      font-name = "Noto Sans 11";
      monospace-font-name = "Source Code Pro 10";
      text-scaling-factor = 1.0;
      font-hinting = "slight";
      font-antialiasing = "grayscale";
      icon-theme = "Adwaita";
      cursor-theme = "Adwaita";
      gtk-theme = "Adwaita-dark";
      clock-show-weekday = true;
      clock-show-date = true;
      clock-show-seconds = false;
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
      picture-options = "zoom";
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = 0;
      picture-options = "zoom";
    };
    "org/gnome/desktop/session" = {
      idle-delay = 300;
    };

    "settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
      power-button-action = "hibernate";
    };

    "shell" = {
      disabled-extensions = ["workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com"];
      enabled-extensions = ["drive-menu@gnome-shell-extensions.gcampax.github.com" "HeadsetControl@lauinger-clan.de" "clipboard-indicator@tudmotu.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com"];
    };
    
    "shell/extensions/HeadsetControl" =  {
      headsetcontrol-executable = "headsetcontrol";
      option-battery = "-b";
      option-capabilities = "-?";
      option-chatmix = "-m";
      option-inactive-time = "-i";
      option-led = "-l";
      option-rotate-mute = "-r";
      option-sidetone = "-s";
      option-voice = "-v";
      ohow-systemindicator = true;
      ose-notifications = false;
      ose-logging = true;
      ose-colors = true;
      oolor-batteryhigh = "rgb(0,255,0)";
      oolor-batterymedium = "rgb(255,255,0)";
      color-batterylow = "rgb(255,0,0)";
    };
  };
}