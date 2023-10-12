{pkgs, ...}:

{
  # The home.stateVersion option does not have a default and must be set
  home.username = "bunny";
  home.homeDirectory = "/home/bunny";
  home.stateVersion = "23.05"; # To figure this out you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    
  # Neofetch
  #

  gtk = {
    enable = true;
    theme = {
      name = "Sweet";
      # package = (pkgs.callPackage ../packages/sweet-theme.nix { });
    };
    iconTheme = {
      name = "candy-icons";
      # package = (pkgs.callPackage ../packages/candy-icons.nix { });
    };
  };

  home.file.".config/neofetch/config.conf" = {
    enable = true;
    text = ''
      # Source: https://github.com/chick2d/neofetch-themes
      # Configuration made by Chick

      # See this wiki page for more info: 
      # https://github.com/dylanaraps/neofetch/wiki/Customizing-Info

      # I used custom seperators as the older one looked not very properly proportioned

      print_info() {
          prin "┌─────────\n Hardware Information \n─────────┐"
          info " ​ ​ 󰌢 " model
          info " ​ ​ 󰍛 " cpu
          info " ​ ​ 󰘚 " gpu
          info " ​ ​  " disk
          info " ​ ​ 󰑭" memory
          info " ​ ​ 󰍹 " resolution
      #    info " ​ ​ 󱈑 " battery 
          prin "├─────────\n Software Information \n─────────┤"
      #    info " ​ ​  " users
          info " ​ ​  " distro
      # Just get your distro's logo off nerdfonts.com
          info " ​ ​  " kernel
          info " ​ ​  " de
          info " ​ ​  " wm
          info " ​ ​  " shell
          info " ​ ​  " term
          info " ​ ​  " term_font
          info " ​ ​  " font
          info " ​ ​  󰉼 " theme
      #    info " ​ ​  󰀻 " icons
          info " ​ ​  " packages 
          info " ​ ​  󰅐 " uptime
      #    info " ​ ​   " gpu_driver  # Linux/macOS only
      #    info " ​ ​  " cpu_usage
      #    info " ​ ​ 󰝚 " song
          # [[ "$player" ]] && prin "Music Player" "$player"
      #    info " ​ ​   " local_ip
      #    info " ​ ​   " public_ip
      #    info " ​ ​   " locale  # This only works on glibc systems.
          prin "└────────────────────────────────────────┘"
          info cols
      prin "\n \n \n \n \n ''${cl3} \n \n ''${cl5} \n \n ''${cl2} \n \n ''${cl6}  \n \n ''${cl4}  \n \n ''${cl1}  \n \n ''${cl7}  \n \n ''${cl0}"
      }

      kernel_shorthand="on"
      distro_shorthand="on"
      os_arch="off"
      uptime_shorthand="on"
      memory_percent="on"
      package_managers="off"
      shell_path="off"
      shell_version="on"
      speed_type="bios_limit"
      speed_shorthand="on"
      cpu_brand="off"
      cpu_speed="off"
      cpu_cores="logical"
      cpu_temp="off"
      gpu_brand="off"
      gpu_type="all"
      refresh_rate="on"
      gtk_shorthand="on"
      gtk2="on"
      gtk3="on"
      public_ip_host="http://ident.me"
      public_ip_timeout=2
      disk_show=('/')
      music_player="vlc"
      song_format="%artist% - %title%"
      song_shorthand="off"
      colors=(distro)
      bold="on"
      underline_enabled="on"
      underline_char="-"
      separator="  "
      color_blocks="off"
      block_range=(0 15) # Colorblocks

      # Colors for custom colorblocks
      magenta="\033[1;35m"
      green="\033[1;32m"
      white="\033[1;37m"
      blue="\033[1;34m"
      red="\033[1;31m"
      black="\033[1;40;30m"
      yellow="\033[1;33m"
      cyan="\033[1;36m"
      reset="\033[0m"
      bgyellow="\033[1;43;33m"
      bgwhite="\033[1;47;37m"
      cl0="''${reset}"
      cl1="''${magenta}"
      cl2="''${green}"
      cl3="''${white}"
      cl4="''${blue}"
      cl5="''${red}"
      cl6="''${yellow}"
      cl7="''${cyan}"
      cl8="''${black}"
      cl9="''${bgyellow}"
      cl10="''${bgwhite}"

      block_width=4
      block_height=1

      bar_char_elapsed="-"
      bar_char_total="="
      bar_border="on"
      bar_length=15
      bar_color_elapsed="distro"
      bar_color_total="distro"

      cpu_display="on"
      memory_display="on"
      battery_display="on"
      disk_display="on"

      image_backend="ascii"
      #image_source="$HOME/"
      image_size="auto"
      image_loop="off"

      aascii_distro="auto"
      ascii_colors=(distro)
      ascii_bold="on"

      thumbnail_dir="''${XDG_CACHE_HOME:-''${HOME}/.cache}/thumbnails/neofetch"
      crop_mode="normal"
      crop_offset="center"

      gap=2

      yoffset=0
      xoffset=0

      stdout="off"
    '';
  };

  # dconf
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
      icon-theme = "candy-icons";
      cursor-theme = "Adwaita";
      # gtk-theme = "Sweet";
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
      disabled-extensions = [""];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "HeadsetControl@lauinger-clan.de"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "clipboard-indicator@tudmotu.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
      ];
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
    "com/gexperts/Tilix" = {
      auto-hide-mouse=true;
      close-with-last-session=false;
      enable-wide-handle=false;
      middle-click-close=true;
      sidebar-on-right=false;
      tab-position="top";
      terminal-title-style="small";
    };
    "com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
      background-transparency-percent=27;
      dim-transparency-percent=0;
      scroll-on-output=false;
      visible-name="Default";
    };
  };
}