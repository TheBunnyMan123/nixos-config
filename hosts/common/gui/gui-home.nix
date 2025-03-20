{
   pkgs,
   inputs,
   outputs,
   buildFirefoxAddon,
   ...
}: {home-manager.users.bunny = {
   imports = [ ../../../modules/vencord.nix ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };
   catppuccin.cursors = {
     flavor = "mocha";
     accent = "mauve";
     enable = true;
   };
   qt.style = {
     name = "kvantum";
   };
   gtk = {
     enable = true;
     cursorTheme = {
       name = "catppuccin-mocha-mauve-cursors";
     };
     font = {
       name = "sans-serif";
     };
     theme = {
       name = "Adwaita-dark";
       package = pkgs.gnome-themes-extra;
     };
   };

   services = {
      hypridle = {
         enable = true;
         settings = {
            general = {
               after_sleep_cmd = "hyprctl dispatch dpms on";
               ignore_dbus_inhibit = false;
               lock_cmd = "hyprlock";
            };

            listener = [
            {
               timeout = 1200; # 20 minutes. Turns off screen
                  on-timeout = "hyprctl dispatch dpms off";
               on-resume = "hyprctl dispatch dpms on";
            }
            ];
         };
      };
   };

   programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Oranchelo";
        show-icons = true;
        terminal = "kitty";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        sidebar-mode = true;
      };
   };

   programs.waybar = {
      enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 43;

            modules-left = ["hyprland/workspaces"];
            modules-center = ["clock" "pulseaudio" "custom/brightness" "custom/clipboard" "custom/poweroff"]; 
            modules-right = ["network" "bluetooth" "cpu" "memory" "disk" "idle_inhibitor" "battery" "tray"];

            "custom/brightness" = {
               exec = "while true; do brightnessctl | grep -oE \"[0-9]+%\"; done";
               restart-interval = 10;
               on-scroll-up = "brightnessctl set 5%+";
               on-scroll-down = "brightnessctl set 5%-";
               format = "󰖨  {}";
            };
            "hyprland/workspaces" = {
               active-only = false;
               format = "{icon}";
               tooltip-format = "{windows}";
               format-window-separator = " ";
            };
            "idle_inhibitor" = {
               format = "{icon}";
               tooltip-format-activated = "Inhibiting Idle";
               tooltip-format-deactivated = "Not Inhibiting Idle";
               format-icons = {
                  activated = "󰖨";
                  deactivated = "󰢠";
               };
            };
            "bluetooth" = {
               on-click = "xterm -class netman -e bluetuith";
               format = "󰂯 {status}";
               format-disabled = "󰂲";
               format-connected = "󰂱 {num_connections} connected";
               tooltip-format = "{controller_alias}\t{controller_address}";
               tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
               tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            };
            "cpu" = {
               interval = 10;
               format = "  {usage}%";
            };
            "disk" = {
               interval = 30;
               format = "  {percentage_used}%";
            };
            "memory" = {
               interval = 30;
               format = "   {percentage}%";
               tooltip-format = "{used}/{total} GiB Used\nSwap: {swapUsed}/{swapTotal} GiB Used";
            };
            "network" = {
               format = "  {essid}";
               format-disconnected = "󰤭";
               format-wifi = "{icon}  {essid}";
               format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];

               on-click = "xterm -class netman -e nmtui";

               format-ethernet = "󰈀  {essid}";

               tooltip-format = "Interface: {ifname}\nIP: {ipaddr}\nSSID: {essid}\nStrength Strength: {signaldBm} dBm\nFrequency: {frequency}\nBandwidth: {bandwidthUpBits}  {bandwidthDownBits}  bits";
            };
            "pulseaudio" = {
               format = "{icon} {volume}%";
               format-icons = {
                  default = ["󰕿" "󰖀" "󰕾"];
                  default-muted = "󰸈";
                  headphone = "󰋋";
                  headphone-muted = "󰟎";
                  speaker = "󰓃";
                  speaker-muted = "󰓄";
                  hdmi = "󰡁";
                  headset = "󰋎";
                  headset-muted = "󰋐";
                  car = "";
                  phone = "󰏲";
                  phone-muted = "";
               };
               scroll-step = 1;
               max-volume = 100;
               on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
            "custom/poweroff" = {
               format = "󰐥";
               on-click = "xterm -class netman -e power-menu";
            };
            "tray" = {
              icon-size = 15;
              spacing = 3;
            };
            "clock" = {
              timezone = "America/Chicago";
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format-alt = "  {:%m/%d/%Y}";
              format = "󰥔  {:%I:%M %p}";
            };
            "battery" = {
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-charging = "󰂄 {capacity}%";
              format-alt = "{icon} {capacity}%";
              max-volume = 100.0;
              reverse-scrolling = 1;
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
            "custom/clipboard" = {
              format = "󰅍";
              on-click = "kitty --class netman -e clipse";
            };
            style = ''
              * {
color: @text;
       font-family: sans-serif;
transition: 0.5s;
              }

            window#waybar {
background: shade(@base, 0.9);
border: 2px solid alpha(@crust, 0.3);
            }

            .modules-left {
              background-color: @surface1;
              padding-left: 20px;
              padding-right: 20px;
              border-top-right-radius: 100px;
              border-bottom-right-radius: 100px;
            }
            .modules-center {
              background-color: @surface1;
              padding-left: 20px;
              padding-right: 20px;
              border-radius: 100px;
            }
            .modules-right {
              background-color: @surface1;
              padding-left: 20px;
              padding-right: 20px;
              border-top-left-radius: 100px;
              border-bottom-left-radius: 100px;
            }

#pulseaudio {
color: @green;
}
#pulseaudio.bluetooth {
color: @blue;
}
#pulseaudio.muted {
color: @red;
}

#custom-brightness {
color: @yellow;
}

#network {
color: @red;
}
#bluetooth {
color: @peach;
}
#cpu {
color: @green;
}
#memory {
color: @sky;
}
#disk {
color: @blue;
}
#idle_inhibitor {
color: @mauve;
}

#workspaces {
padding: 0;
         font-family: "MesloLGS Nerd Font Mono";
}
#workspaces button {
margin: 0;
        margin-left: 3px;
        margin-right: 3px;
padding: 0;
         background-color: @base;
         border-radius: 100px;
}
#workspaces button.active {
  background-color: @lavender;
}
#workspaces button.active * {
color: @base;
}
#workspaces button:hover {
  background-color: @text;
}
#workspaces button:hover * {
color: @base;
}
#workspaces button * {
padding: 0;
margin: 0;
        margin-left: 3px;
        margin-right: 3px;
color: @sapphire;
}

.modules-left * {
margin: 7px;
}
.modules-center * {
margin: 7px;
}
.modules-right * {
margin: 7px;
}

#battery {
color: @green;
}
#battery.charging {
color: @yellow;
}
#battery.warning:not(.charging) {
color: @red;
}
'';
         };
      };
   };

programs.zsh.initExtraFirst = ''
if [[ "$(tty)" == "/dev/tty1" ]]
then
exec Hyprland
fi
'';

services.hyprpaper = {
  enable = false;
  settings = {
    ipc = "off";
    splash = false;
    splash_offset = 2.0;

    preload = [ "${../../../extrafiles/catppuccin_triangle.png}" ];
    wallpaper = [ ",${../../../extrafiles/catppuccin_triangle.png}" ];
  };
};

wayland.windowManager.hyprland = {
  enable = true;
  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  xwayland.enable = true;
  systemd.variables = ["--all"];
  settings = {
    "$mod" = "SUPER";

    misc = {
      force_default_wallpaper = 2;
    };

    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 2;
      "col.inactive_border" = "$crust";
      "col.active_border" = "$mauve";
      resize_on_border = false;
      allow_tearing = false;
      layout = "master";
    };

    exec-once = [
      "waybar"
        "swaync"
        "[workspace 1 silent] sleep 5 && kitty"
        "[workspace 1 silent] sleep 7 && kitty -e bash -c 'TERM=xterm-kitty yazi'"
        "[workspace 2 silent] sleep 7 && keepassxc"
        "[workspace 3 silent] sleep 5 && vesktop"
        "[workspace 2 silent] sleep 5 && chromium"
        "clipse -listen"
    ];

    decoration = {
      rounding = 10;

      active_opacity = 1.0;
      inactive_opacity = 0.95;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    master = {
#
    };

    input = {
      kb_layout = "us";

      follow_mouse = 1;
      sensitivity = 0;

      touchpad = {
        natural_scroll = false;
        disable_while_typing = false;
      };
    };

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 0, 0, myBezier"
          "windowsOut, 0, 0, default, popin 80%"
          "border, 0, 0, default"
          "borderangle, 0, 0, default"
          "fade, 0, 0, default"
          "workspaces, 1, 4, default"
      ];
    };

    bind = [
# Volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ --limit 1 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "bind=$mod, N, layoutmsg, swapwithmaster master"
        "$mod, F, exec, firefox-esr"
        "$mod, B, exec, chromium"
        "$mod, Q, exec, kitty tmux new -A"
        "SUPER_SHIFT, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, R, exec, rofi -show drun"
        ''$mod, S, exec, bash -c 'grimblast --freeze copysave area "$(date +"$HOME/Pictures/scrn-%m-%d-%y-%H-%M-%S.png")"' ''
        "$mod, D, fullscreen,"

# Movement
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, H, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"
        "$mod, left, movefocus, l"
        ] ++ (# Workspaces
            builtins.concatLists(builtins.genList(
                x: let
                wspace = let
                c = (x + 1) / 10;
                in builtins.toString(x + 1 - (c * 10));
                in [
                "$mod, ${wspace}, workspace, ${toString(x + 1)}"
                "$mod SHIFT, ${wspace}, movetoworkspace, ${toString(x + 1)}"
                ]
                ) 10)
            );

    bindm = [
      "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
    ];

    windowrulev2 = [
      "suppressevent maximize, class:.*"
        "float, class:(netman)"
        "tile, initialClass:([Mm]inecraft.*)"
        "workspace 3, class:(vesktop)"
        "float, initialTitle:Picture-in-Picture"
        "size 544 306, initialTitle:Picture-in-Picture"
        "move 1340 80, initialTitle:Picture-in-Picture"
    ];

    env = [
      "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,catppuccin-mocha-blue-cursors"
        "HYPRCURSOR_THEME,catppuccin-mocha-blue-cursors"
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
    ];

      cursor = {
         no_hardware_cursors = true;
      };
   };
};
   programs.thunderbird = {
      enable = true;
      package = pkgs.thunderbird-128.override {
         extraPolicies.ExtensionSettings = {
            "{47ef7cc0-2201-11da-8cd6-0800200c9a66}" = {
               installation_mode = "normal_installed";
               install_url = "https://addons.thunderbird.net/thunderbird/downloads/file/1030815/correct_identity-2.4.1-tb.xpi";
            };
         };
      };
      profiles = {
         default = {
            isDefault = true;
         };
      };
   };

   home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
      prismlauncher
      imagemagick
      blockbench
      jetbrains.idea-community-bin
   ];

   programs.chromium = {
      enable = true;
      commandLineArgs = [ "--disable-gpu-compositing" ];
      extensions = [
         "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin (lite)
         "enamippconapkdmgfgjchkhakpfinmaj" # dearrow
         "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
         "fphegifdehlodcepfkgofelcenelpedj" # 7tv
         "oboonakemofpalcgghocfoadofidjkkk" # keepassxc-browser
         "fkagelmloambgokoeokbpihmgpkbgbfm" # indie wiki buddy
         "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin
      ];
   };

   home.file.".config/kitty/kitty.conf.d".source = "${../../../extrafiles/kitty.conf.d}";
   home.file.".local/share/PrismLauncher/themes/Console".source = "${../../../extrafiles/PrismLauncherTheme_Console}";
   home.file.".mozilla/firefox/default/chrome".source = "${../../../extrafiles/firefox-chrome}";
   programs.firefox = {
      enable = true;
      package = pkgs.firefox-esr;
      languagePacks = [
         "en-US"
      ];
      nativeMessagingHosts = [
         pkgs.keepassxc
      ];
      profiles = {
         default = {
            search = {
               force = true;
               default = "Startpage";

               engines = {
                  google.metaData.hidden = true;
                  bing.metaData.hidden = true;
                  ddq.metaData.hidden = true;

                  "Startpage" = {
                     urls = [
                     {
                        template = "https://www.startpage.com/search?";
                        params = [
                        {
                           name = "q";
                           value = "{searchTerms}";
                        }
                        {
                           name = "prfe"; # Prefrences
                              value = "bc3209305886c353223c0b24bbbd4b264f6723e204a7c160c995ef160d825ee6e453891cee1ad4284c542e46e44ec96b3d5d0f3b4541dc6e6b49dd3dccf1c6ef535346957054d55b5ebc8d40";
                        }
                        ];
                     }
                     ];

                     icon = "https://www.startpage.com/favicon.ico";
                     updateInterval = 7 * 24 * 60 * 60 * 1000; # every week
                        definedAliases = [ "@sp" ];
                  };
                  "NixOS Wiki" = {
                     urls = [
                     {
                        template = "https://wiki.nixos.org/w/index.php";
                        params = [
                        {
                           name = "search";
                           value = "{searchTerms}";
                        }
                        ];
                     }
                     ];

                     icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                     definedAliases = [ "@nw" ];
                  };
                  "Nix Packages" = {
                     urls = [
                     {
                        template = "https://search.nixos.org/packages?";
                        params = [
                        {
                           name = "channel";
                           value = "unstable";
                        }
                        {
                           name = "query";
                           value = "{searchTerms}";
                        }
                        ];
                     }
                     ];

                     icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                     definedAliases = [ "@np" ];
                  };
                  "NixOS Options" = {
                     urls = [
                     {
                        template = "https://search.nixos.org/options?";
                        params = [
                        {
                           name = "channel";
                           value = "unstable";
                        }
                        {
                           name = "query";
                           value = "{searchTerms}";
                        }
                        ];
                     }
                     ];

                     icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                     definedAliases = [ "@no" ];
                  };
               };
            };
            extensions.packages = [
               (buildFirefoxAddon {
                name = "sidebery";
                version = "5.2.0.9";
                url = "https://github.com/mbnuqw/sidebery/releases/download/v5.2.0/sidebery-5.2.0.9.xpi";
                hash = "sha256-iF/2SE5bYy9mJU8lCGm8IXW0pugxxDtepFbqInDNaHE=";
              })
              (buildFirefoxAddon {
                name = "keepassxc";
                version = "1.9.3";
                url = "https://github.com/keepassxreboot/keepassxc-browser/releases/download/1.9.3/keepassxc-browser_1.9.3_firefox.zip";
                hash = "sha256-+Z3DW7GXpqBxSTiQBPEH9E/uxCYkq9Ad/3yUGwKyKgI=";
                fixedExtid = "keepassxc-browser@keepassxc.org";
              })
              (buildFirefoxAddon {
                name = "ublock";
                version = "1.59.0";
                url = "https://github.com/gorhill/uBlock/releases/download/1.59.0/uBlock0_1.59.0.firefox.signed.xpi";
                hash = "sha256-HbnGdqB9FB+NNtu8JPnj1kpswjQNv8bISLxDlfls+xQ=";
              })
              #(buildFirefoxAddon {
              #  name = "7tv";
              #  version = "3.1.1";
              #  url = "https://github.com/SevenTV/Extension/releases/download/v3.1.1/7tv-webextension-ext.xpi";
              #  hash = "sha256-1CKdE+m6UtEQY169X4NTCrI03mh3s2Pn43ddbiWEseI=";
              #})
              (buildFirefoxAddon {
                name = "sponsorblock";
                version = "5.7";
                url = "https://github.com/ajayyy/SponsorBlock/releases/download/5.7/FirefoxSignedInstaller.xpi";
                hash = "sha256-ZP1ygz9pkai4/RQ6IP/Sty0NN2sDiDA7d7Ke8GyZmy0=";
              })
              (buildFirefoxAddon {
                name = "stylus";
                version = "1.5.51";
                url = "https://addons.mozilla.org/firefox/downloads/file/4338993/styl_us-1.5.51.xpi";
                hash = "sha256-TXwYSvLYH0DDXzPHfEBA3EIFkI289l58mfr9fSbkgU8=";
              })
              (buildFirefoxAddon {
                name = "dearrow";
                version = "1.7.1";
                url = "https://github.com/ajayyy/DeArrow/releases/download/1.7.1/FirefoxSignedInstaller.xpi";
                hash = "sha256-xwAMcMT8zG6byAOAAT3rHMmAdyjeNG1vVjZkITcu9ug=";
              })
            ];
            settings = {
# Misc
               "browser.display.windows.non_native_menus" = 0;
               "browser.tabs.inTitlebar" = 0;
               "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

# new tab and extensions
               "browser.aboutConfig.showWarning" = false;
               "browser.startup.page" = 1;
               "browser.startup.homepage" = "about:home";
               "browser.newtabpage.activity-stream.feeds.telemetry" = false;
               "browser.newtabpage.activity-stream.telemetry" = false;
               "browser.newtabpage.activity-stream.feeds.snippets" = false;
               "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
               "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
               "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
               "browser.newtabpage.activity-stream.showSponsored" = false;
               "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
               "browser.newtabpage.activity-stream.default.sites" = "";

# use mozilla geolocation
               "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
               "geo.provider.use_gpsd" = false;
               "geo.provider.use_geoclue" = false;
               "browser.region.network.url" = false;
               "browser.region.update.enabled" = false;

# I forgor
               "intl.accept_languages" = "en-US, en";
               "javascript.use_us_english_locale" = true;

# Auto Update & Extension Reccomendations
               "app.update.auto" = false;
               "extensions.getAddons.showPane" = false;
               "extensions.htmlaboutaddons.recommendations.enabled" = false;
               "browser.discovery.enabled" = false;

# telemetry
               "datareporting.policy.dataSubmissionEnabled" = false;
               "datareporting.healthreport.uploadEnabled" = false;
               "toolkit.telemetry.enabled" = false;
               "toolkit.telemetry.unified" = false;
               "toolkit.telemetry.server" = "data:,";
               "toolkit.telemetry.archive.enabled" = false;
               "toolkit.telemetry.newProfilePing.enabled" = false;
               "toolkit.telemetry.shutdownPingSender.enabled" = false;
               "toolkit.telemetry.updatePing.enabled" = false;
               "toolkit.telemetry.bhrPing.enabled" = false;
               "toolkit.telemetry.firstShutdownPing.enabled" = false;
               "toolkit.telemetry.coverage.opt-out" = true;
               "toolkit.coverage.opt-out" = true;
               "toolkit.coverage.endpoint.base" = "";
               "browser.ping-centre.telemetry" = false;
               "beacon.enabled" = false;

# Studies
               "app.shield.optoutstudies.enabled" = false;
               "app.normandy.enabled" = false;
               "app.normandy.api_url" = "";

# Crash reports
               "breakpad.reportURL" = "";
               "browser.tabs.crashReporting.sendReport" = false;

# Passwords
               "signon.rememberSignons" = false;
               "signon.autofillForms" = false;
               "signon.formlessCapture.enabled" = false;

# HTTPS
               "dom.security.https_only_mode" = true;
               "dom.security.https_only_mode_send_http_background_request" = false;
               "browser.xul.error_pages.expert_bad_cert" = true;
               "security.tls.enable_0rtt_data" = false;
               "security.OCSP.require" = true;
               "security.pki.sha1_enforcement_level" = 1;
               "security.cert_pinning.enforcement_level" = 2;
               "security.remote_settings.crlite_filters.enabled" = true;
               "security.pki.crlite_mode" = 2;

# Referer
               "network.http.referer.XOriginPolicy" = 2;
               "network.http.referer.XOriginTrimmingPolicy" = 2;

# A/V
               "media.peerconnection.enabled" = false;
               "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
               "media.peerconnection.ice.default_address_only" = true;
               "media.peerconnection.ice.no_host" = true;
               "media.autoplay.default" = 5;

# UI
               "dom.disable_open_during_load" = true;
               "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
               "extensions.pocket.enabled" = false;
               "extensions.Screenshots.disabled" = true;
               "pdfjs.enableScripting" = false;

# Extensions
               "extensions.enabledScopes" = 5;
               "extensions.webextensions.restrictedDomains" = "";
               "extensions.postDownloadThirdPartyPrompt" = false;
               "extensions.autoDisableScopes" = 0;
               "xpinstall.signatures.required" = false;

# Shutdown Settings
               "network.cookie.lifetimePolicy" = 2;
               "privacy.sanitize.sanitizeOnShutdown" = true;
               "privacy.clearOnShutdown.cache" = true;
               "privacy.clearOnShutdown.cookies" = true;
               "privacy.clearOnShutdown.downloads" = true;
               "privacy.clearOnShutdown.formdata" = true;
               "privacy.clearOnShutdown.history" = true;
               "privacy.clearOnShutdown.offlineApps" = true;
               "privacy.clearOnShutdown.sessions" = true;
               "privacy.clearOnShutdown.sitesettings" = false;
               "privacy.sanitize.timeSpan" = 0;

# Fingerprinting
               "privacy.resistFingerprinting" = true;
               "privacy.window.maxInnerWidth" = 1600;
               "privacy.window.maxInnerHeight" = 900;
               "privacy.resistFingerprinting.block_mozAddonManager" = true;
               "browser.display.use_system_colors" = false;
               "browser.startup.blankWindow" = false;
            };
            id = 0;
            isDefault = true;
         };
      };
   };

      programs.kitty = {
        enable = true;
        font = {
          name = "monospace";
          size = 11;
        };
        shellIntegration = {
          enableZshIntegration = true;
          mode = "no-rc";
        };
        extraConfig = ''
          globinclude ../../../kitty.conf.d/**/*.conf
          '';
      };
programs.vencord = {
  enable = true;
  package = pkgs.vencord;
  themes = {
         system24-catppuccin-mocha = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/refact0r/system24/9d480b7e3bc0dac994a9c496b63d6875368f9a98/theme/flavors/catppuccin-mocha.theme.css";
            hash = "sha256-e8/3bEYL/Wl9VZENWkusi50inal0ApQOKjpmS8T852Y=";
          };
        };
        plugins = {
          Experiments.enabled = true;
          AutomodContext.enabled = true;
          BetterRoleContext.enabled = true;
          CopyEmojiMarkdown = {
            enabled = true;
            copyUnicode = true;
         };
         CopyUserURLs.enabled = true;
         Dearrow = {
            enabled = true;
            hideButton = false;
            replaceElements = 0;
         };
         ForceOwnerCrown.enabled = true;
         FriendsSince.enabled = true;
         MessageLoggerEnhanced.enabled = true;
         ImplicitRelationships.enabled = true;
         KeepCurrentChannel.enabled = true;
         MessageLinkEmbeds = {
            enabled = true;
            listMode = "blacklist";
            idList = "";
            automodEmbeds = "never";
         };
         MoreUserTags = {
            enabled = true;
            tagSettings = {
               WEBHOOK = {
                  text = "WebHook";
                  showInChat = true;
                  showInNotChat = true;
               };
               OWNER = {
                  text = "Owner";
                  showInChat = true;
                  showInNotChat = true;
               };
               ADMINISTRATOR = {
                  text = "Admin";
                  showInChat = true;
                  showInNotChat = true;
               };
               MODERATOR_STAFF = {
                  text = "Staff";
                  showInChat = true;
                  showInNotChat = true;
               };
               MODERATOR = {
                  text = "Mod";
                  showInChat = true;
                  showInNotChat = true;
               };
               VOICE_MODERATOR = {
                  text = "VC Mod";
                  showInChat = true;
                  showInNotChat = true;
               };
               CHAT_MODERATOR = {
                  text = "Chat Mod";
                  showInChat = true;
                  showInNotChat = true;
               };
            };
         };
         MutualGroupDMs.enabled = true;
         NoOnboardingDelay.enabled = true;
         NormalizeMessageLinks.enabled = true;
         PictureInPicture.enabled = true;
         PlatformIndicators = {
            enabled = true;
            colorMobileIndicator = true;
            list = true;
            badges = true;
            messages = true;
         };
         RelationshipNotifier.enabled = true;
         Summaries = {
            enabled = true;
            summaryExpiryThresholdDays = 3;
         };
         ShowHiddenThings = {
            enabled = true;
            showTimeouts = true;
            showInvitesPaused = true;
            showModView = true;
            disableDiscoveryFilters = true;
            disableDisallowedDiscoveryFilters = true;
         };
         ShowHiddenChannels.enabled = true;
         SilentTyping = {
            enabled = true;
            showIcon = true;
            contextMenu = true;
            isEnabled = true;
         };
         TypingTweaks = {
            enabled = true;
            alternativeFormatting = true;
            showRoleColors = true;
            showAvatars = true;
         };
         ValidReply.enabled = true;
         ValidUser.enabled = true;
         ViewRaw.enabled = true;
         VoiceDownload.enabled = true;
         NoTrack = {
            enabled = true;
            disableAnalytics = true;
         };
         Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
         };
         FixSpotifyEmbeds.enabled = true;
         FixYoutubeEmbeds.enabled = true;
         YoutubeAdblock.enabled = true;
         WatchTogetherAdblock.enabled = true;
         NewPluginsManager.enabled = true;
         NoProfileThemes.enabled = true;
         ColorSighted.enabled = true;
         BetterFolders = {
            enabled = false; # Currently broken
               sidebar = true;
            sidebarAnim = true;
            closeAllFolders = true;
            closeAllHomeButton = true;
            closeOthers = true;
            forceOpen = true;
            keepIcons = true;
            showFolderIcon = 1;
         };
         PlainFolderIcon.enabled = true;
         FullUserInChatbox.enabled = true;
         IrcColors.enabled = true;
      };
      userPlugins = {
         NewPluginsManager = "github:sqaaakoi/vc-newpluginsmanager/6f6fa79ea1dabaebf3c176eb1e61a4a80c6d9f97";
         MessageLoggerEnhanced = "github:syncxv/vc-message-logger-enhanced/3fb2fe04b8e38813290309836983309a83ffe00c";
      };
   };
   programs.vesktop = {
      enable = true;
   };

   dconf = {
     enable = true;
     settings = {
       "org/gnome/desktop/interface" = {
         color-scheme = "prefer-dark";
       };
     };
   };
};}

