{
   inputs,
   buildFirefoxAddon
}: {
   gui ? false
}: {
   pkgs, 
   lib,
   ...
}: {home-manager.users.bunny = {
  catppuccin = {
    enable = gui;
    flavor = "mocha";
    accent = "mauve";
  };
   catppuccin.cursors = {
     flavor = "mocha";
     accent = "mauve";
     enable = gui;
   };
   qt.style = {
     name = "kvantum";
   };
   gtk = {
     enable = gui;
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


      services.hypridle = {
         enable = gui;
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

   programs.rofi = {
      enable = gui;
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
      enable = gui;
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
          };
        };
      style = ''
             * {
color: @text;
       font-family: sans-serif;
transition: 0.5s;
             }

          window#waybar {
background: @base;
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

programs.zsh.initExtraFirst = ''
if [[ "$(tty)" == "/dev/tty1" ]]
then
exec Hyprland
fi
'';

services.hyprpaper = {
  enable = true;
  settings = {
    wallpaper = ", /home/bunny/solace-wallpaper-pack/Lake 1.png";
  };
};

wayland.windowManager.hyprland = {
  enable = gui;
  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  xwayland.enable = gui;
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
        "[workspace 1 silent] sleep 5 && kitty -c 'tmux new -A'"
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
        "$mod, B, exec, chromium"
        "$mod, Q, exec, kitty tmux new -A"
        "SUPER_SHIFT, Q, exec, kitty"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, R, exec, rofi -show drun"
        ''$mod, S, exec, bash -c 'grimblast --freeze copysave area "$(date +"$HOME/Pictures/scrn-%m-%d-%y-%H-%M-%S.png")"' ''
        "$mod, D, fullscreen,"
        "SUPER_SHIFT, L, exec, hyprctl --batch \"dispatch resizeactive 1440 1440; dispatch centerwindow\""

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
        "size 544 306, initialTitle:Picture in Picture"
        "move 1340 80, initialTitle:Picture in Picture"
    ];

    env = [
      "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
    ];

      cursor = {
         no_hardware_cursors = true;
      };
   };
};
   programs.thunderbird = {
      enable = gui;
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
      enable = gui;
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

   home.file.".config/timewall".source = "${../../../extrafiles/timewall}";
   home.file.".config/kitty/kitty.conf.d".source = "${../../../extrafiles/kitty.conf.d}";
   home.file.".local/share/PrismLauncher/themes/Console".source = "${../../../extrafiles/PrismLauncherTheme_Console}";

      programs.kitty = {
        enable = gui;
        font = {
          name = "monospace";
          size = 11;
        };
        shellIntegration = {
          enableZshIntegration = true;
          mode = "no-rc";
        };
        extraConfig = ''
          globinclude ./kitty.conf.d/*.conf
          '';
      };
programs.vesktop.vencord = {
     settings = {
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
      enabledThemes = ["midnight.css"];
     };
     themes = {
        midnight = ../../../extrafiles/midnight-discord-theme.css;
     };
   };
   programs.vesktop = {
      enable = true;
   };

   dconf = {
     enable = gui;
     settings = {
       "org/gnome/desktop/interface" = {
         color-scheme = "prefer-dark";
       };
     };
   };
};}

