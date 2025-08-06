{
   pkgs,
   lib,
   config,
   ...
}: {
   qt.style = {
      name = "kvantum";
   };

   catppuccin.enable = lib.mkForce false;

   catppuccin.cursors = {
      enable = true;
      flavor = "mocha";
      accent = "mauve";
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
               timeout = 1200;

               on-timeout = "hyprctl dispatch dpms off";
               on-resume = "hyprctl dispatch dpms on";
            }
            ];
         };
      };
   };

   programs = {
      rofi = {
         enable = true;
         package = pkgs.rofi-wayland;
         font = "monospace 12";
         modes = ["run" "drun"];
         terminal = "${config.programs.kitty.package}/bin/kitty";
 
         theme = let
            inherit (config.lib.formats.rasi) mkLiteral;
         in {
            "*" = {
               background-color = mkLiteral "#d67782";
               border-color = mkLiteral "#7b4255";
               foreground-color = mkLiteral "#ffffff";
               width = 512;
            };

            "inputbar" = {
               children = map mkLiteral [ "prompt" "entry" ];
               border = mkLiteral "0 solid 0 2px 0";
            };

            "window" = {
               border = mkLiteral "2px solid";
            };

            "#textbar-prompt-colon" = {
               expand = false;
               str = ":";
               margin = mkLiteral "0 0.3em 0 0";
               text-color = mkLiteral "@foreground-color";
            };

            "element" = {
               spacing = mkLiteral "0";
            };

            "button" = {
               border = mkLiteral "2px solid 0 0 0";
            };

            "button selected" = {
               background-color = mkLiteral "#9d5d7a";
            };
         };

         extraConfig = {
            show-icons = true;
            disable-history = false;
            hide-scrollbar = true;
            sidebar-mode = true;

            drun-display-format = "{icon} {name}";
            display-drun = "   Apps ";
            display-run = "   Run ";

            location = 0;
         };
      };

      waybar = {
         enable = true;
         
         settings = {
            mainBar = {
               layer = "top";
               height = 46;

               modules-left = ["hyprland/workspaces" "clock"];
               modules-right = ["network" "memory" "disk" "idle_inhibitor" "battery" "tray"];
               
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
                  formaat-icons = {
                  activated = "󰖨";
                     deactivated = "󰢠";
                  };
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
            };
         };

         style = ''
            * {
               color: rgb(0.1, 0.1, 0.1);
               font-family: sans-serif;
               transition: 0.5s;
            }

            window#waybar {
               background: transparent;
            }

            .modules-left, .modules-right {
               background-color: rgba(0.1, 0.1, 0.1, 0.1);
               margin: 10px;
               padding: 0;
               border-radius: 15px;
            }

            .modules-left * {
               margin: 5px;
            }
            .modules-right * {
               margin: 5px;
            }

            #workspaces {
               margin: 0;
               padding: 0;
               font-family: "monospace";
            }

            #workspaces button {
               margin: 0;
               padding: 0;
               padding-left: 2px;
               padding-right: 2px;
               margin-left: 3px;
               margin-right: 3px;
               background-color: rgba(0.1, 0.1, 0.1, 0.1);
               border-radius: 15px;
            }

            #workspaces button * {
               padding: 0;
               margin: 0;
               color: rgb(1, 1, 1);
               margin-left: 3px;
               margin-right: 3px;
            }

            #workspaces button.active {
               background-color: rgba(1, 1, 1, 0.1);
            }

            #workspaces button.active * {
               color: rgb(0.1, 0.1, 0.1);
            }

            #workspaces button:hover {
               background-color: rgba(1, 1, 1, 0.1);
            }

            #workspaces button:hover * {
               color: rgb(0.1, 0.1, 0.1);
            }
         '';
      };

      zsh.initContent = lib.mkOrder 0 ''
         if [[ "$(tty)" == "/dev/tty1" ]]
         then
            exec Hyprland
         fi
      '';

      chromium = {
         enable = true;
         package = (pkgs.chromium.override { enableWideVine = true; });

         commandLineArgs = [
            "--enable-features=UseOzonePlatform"
            "--enable-features=WebRTCPipeWireCapturer"

            "--ozone-platform-hint=auto"
            "--ozone-platform=wayland"

            "--ignore-gpu-blocklist"
            "--enable-gpu-rasterization"

            "--enable-zero-copy"
            "--gtk-version=4"
            "--enable-vulkan"
            "--use-gl=desktop"
         ];

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

      kitty = {
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
            globinclude ./kitty.conf.d/*.conf
         '';
      };

      vesktop.enable = true;
      vesktop.vencord = {
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
               FullUserInChatbox.enabled = true;
               IrcColors.enabled = true;
            };
         };
      };

      mpvpaper = {
         enable = true;
      };
   };
   xdg.configFile."mpvpaper/pauselist".source = lib.mkDefault ./extrafiles/empty.txt;
   xdg.configFile."mpvpaper/stoplist".source = lib.mkDefault ./extrafiles/empty.txt;

   home = {
      packages = with pkgs; [
         libsForQt5.qtstyleplugin-kvantum
         qt6Packages.qtstyleplugin-kvantum

         prismlauncher
         imagemagick
         blockbench
      ];

      file = {
         ".config/kitty/kitty.conf.d".source = "${./extrafiles/kitty.conf.d}";
      };
   };

   wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.variables = ["--all"];

      settings = {
         "$mod" = "SUPER";
         "$mod_alt" = "SUPER_SHIFT";

         general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;

            "col.inactive_border" = "rgb(1a1a1a)";
            "col.active_border" = "rgb(b3e0f2)";
            layout = "master";

            resize_on_border = false;
            allow_tearing = false;
         };

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
               "windows, 1, 5, myBezier"
               "windowsOut, 1, 5, myBezier"
               "workspaces, 1, 5, myBezier"
               
               "border, 0, 0, default"
               "borderangle, 0, 0, default"
               "fade, 0, 0, default"
            ];
         };

         exec-once = [
            "waybar"
            "swaync"
            "clipse -listen"
            "mpvpaper all -o \"--loop-file=inf --interpolation --video-sync=display-resample --no-cache --profile=low-latency\" ${./extrafiles/shader-render.mp4}"

            "[workspace 1 silent] kitty -c 'tmux new -A'"
            "[workspace 2 silent] keepassxc"
            "[workspace 2 silent] chromium"
            "[workspace 3 silent] vesktop"
         ];

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
         ] ++ (
         # Workspaces
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
            "tile, initialClass:([Mm]inecraft.*)"
            "workspace 3, class:(vesktop)"
            "float, initialTitle:Picture in Picture"
            "size 544 306, initialTitle:Picture in Picture"
            "move 56 80, initialTitle:Picture in Picture"
         ];

         env = [
            "XCURSOR_SIZE, 24"
            "HYPRCURSOR_SIZE, 24"
            "XCURSOR_THEME, catppuccin-mocha-mauve-cursors"
            "HYPRCURSOR_THEME, catppuccin-mocha-mauve-cursors"

            "WLR_NO_HARDWARE_CURSORS, 1"
         ];

         cursor = {
            no_hardware_cursors = true;
         };
      };
   };

   dconf = {
      enable = true;
      settings = {
         "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
         };
      };
   };
}

