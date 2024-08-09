{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users = {
    bunny = {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          exec-once = [
            "steam -silent"
          ];
        };
      };
    };
  };
}

