{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users = {
    bunny = {
      gtk = {
        enable = true;
        cursorTheme = {
          name = "catppuccin-macchiato-blue";
          package = pkgs.catppuccin-cursors.macchiatoBlue;
        };
        gtk2.extraConfig = "gtk-application-prefer-dark-theme=1";
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme=1;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme=1;
        };
      };

      programs.waybar = {
        enable = true;
        catppuccin = {
          enable = true;
          flavor = "macchiato";
        };
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 43;

            modules-left = ["hyprland/workspaces"];
            modules-center = ["clock" "pulseaudio" "battery"];
            modules-right = ["network" "bluetooth" "cpu" "memory" "disk" "battery" "tray"];

            "hyprland/workspaces" = {
              active-only = false;
              format = "{icon}";
              tooltip-format = "{windows}";
              format-window-separator = " ";
            };
            "bluetooth" = {
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
            };
            "tray" = {
              icon-size = 15;
              spacing = 3;
            };
            "clock" = {
              timezone = "America/Chicago";
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format-alt = " {:%d/%m/%Y}";
              format = "󰥔 {:%H:%M}";
            };
            "battery" = {
             states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-charging = "󰂄";
              format-alt = "{icon}";
              max-volume = 100.0;
              reverse-scrolling = 1;
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
          };
        };
        style = ''
          * {
            color: @text;
            font-family: sans-serif;
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
          #battery {
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

      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        xwayland.enable = true;
        systemd.variables = ["--all"];
        catppuccin = {
          enable = true;
          flavor = "macchiato";
          accent = "blue";
        };
        settings = {
          "$mod" = "SUPER";

          general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 2;
            resize_on_border = false;
            allow_tearing = false;
            layout = "dwindle";
          };

          exec-once = [
            "waybar"
            "swaync"
            "[workspace 1 silent] kitty"
            "[workspace 1 silent] keepassxc"
            "[workspace 3 silent] vesktop"
            "[workspace 2 silent] firefox-developer-edition"
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

          dwindle = {
            pseudotile = true;
            preserve_split = true;
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

            "$mod, F, exec, firefox-developer-edition"
            "$mod, Q, exec, kitty"
            "$mod, C, killactive,"
            "$mod, M, exit,"
            "$mod, V, togglefloating,"
            "$mod, R, exec, wofi --show drun"
            
            # Dwindle
            "$mod, P, pseudo,"
            "$mod, O, togglesplit,"

            # Movement
            "$mod, H, movefocus, r"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, l"
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
            "float, initialTitle:Picture-in-Picture"
          ];

          env = [
            "XCURSOR_SIZE,24"
            "HYPRCURSOR_SIZE,24"
            "MOZ_ENABLE_WAYLAND,1"
          ];

          cursor = {
            no_hardware_cursors = true;
          };
        };
      };
    };
  };
}
