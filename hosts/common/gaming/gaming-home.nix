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
            "sleep 5 && steam -silent"
          ];
        };
      };
    };
  };
}

