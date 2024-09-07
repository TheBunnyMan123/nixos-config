{
  pkgs,
  inputs,
  ...
}: {
  users.users.bunny.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    prismlauncher
    imagemagick
  ];
  home-manager.users = {
    bunny = {
      programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        package = pkgs.vscodium;

        extensions = with pkgs.vscode-extensions; [
          mhutchie.git-graph
          jnoortheen.nix-ide
          aaron-bond.better-comments
          pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons
          pkgs.vscode-extensions.catppuccin.catppuccin-vsc
        ];

        userSettings = {
          "workbench.colorTheme" = "Catppuccin Mocha";
          "workbench.iconTheme" = "catppuccin-mocha";
        };
      };

      programs.kitty = {
        enable = true;
        catppuccin = {
          flavor = "mocha";
          enable = true;
        };
        font = {
          name = "monospace";
          size = 11;
        };
        shellIntegration = {
          enableZshIntegration = true;
          mode = "no-rc";
        };
      };

      programs.vencord = {
        enable = true;
        package = pkgs.vencord;
        themes = {
          catppuccin = pkgs.fetchurl {
            url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css";
            hash = "sha256-OaQofvUCGD50/LPu7tf3zZ9/GEktGCoeZ3J4ujtCcTE=";
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
            enabled = true;
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
        };
        userPlugins = {
          NewPluginsManager = "github:sqaaakoi/vc-newpluginsmanager/6f6fa79ea1dabaebf3c176eb1e61a4a80c6d9f97";
          MessageLoggerEnhanced = "github:syncxv/vc-message-logger-enhanced/3fb2fe04b8e38813290309836983309a83ffe00c";
        };
      };
      programs.vesktop = {
        enable = true;
      };

      # WM
      catppuccin.pointerCursor = {
        flavor = "mocha";
        accent = "mauve";
        enable = true;
      };
      qt.style = {
        name = "kvantum";
        catppuccin = {
          flavor = "mocha";
          accent = "mauve";
          enable = true;
        };
      };
      gtk = {
        enable = true;
        cursorTheme = {
          name = "catppuccin-mocha-blue-cursors";
          package = pkgs.catppuccin-cursors.mochaMauve;
        };
        font = {
          name = "sans-serif";
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
        catppuccin = {
          enable = true;
          flavor = "mocha";
        };
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
        catppuccin = {
          enable = true;
          flavor = "mocha";
        };
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 43;

            modules-left = ["hyprland/workspaces"];
            modules-center = ["clock" "pulseaudio" "custom/clipboard" "custom/poweroff"]; 
            modules-right = ["network" "bluetooth" "cpu" "memory" "disk" "idle_inhibitor" "battery" "tray"];

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
        catppuccin = {
          enable = true;
          flavor = "mocha";
          accent = "mauve";
        };
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
            "hypridle"
            "waybar"
            "swaync"
            "[workspace 1 silent] sleep 5 && kitty"
            "[workspace 1 silent] sleep 7 && kitty -e bash -c 'TERM=xterm-kitty yazi'"
            "[workspace 2 silent] sleep 7 && keepassxc"
            "[workspace 3 silent] sleep 5 && vesktop"
            "[workspace 2 silent] sleep 5 && firefox-developer-edition"
            "clipse -listen"
          ];

          decoration = {
            rounding = 10;

            active_opacity = 1.0;
            inactive_opacity = 0.95;

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
            "col.shadow" = "rgba(1a1a1aee)";

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
            };
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          bind = [
            # Volume
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ --limit 1 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            "bind=$mod, N, layoutmsg, swapwithmaster master"
            "$mod, F, exec, firefox-developer-edition"
            "$mod, Q, exec, kitty"
            "$mod, C, killactive,"
            "$mod SHIFT, C, exit,"
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
    };
  };
}

