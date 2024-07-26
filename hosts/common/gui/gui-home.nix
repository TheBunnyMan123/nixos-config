{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users = {
    bunny = {
      wayland.windowManager.hyprland = {
        enabled = true;
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

          decoration = {
            rounding = 10;

            active_opacity = 1.0;
            inactive_opacity = 0.95;

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
            col.shadow = "rgba(1a1a1aee)";

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
            enable = true;
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

