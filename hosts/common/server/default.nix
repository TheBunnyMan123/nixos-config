{
  lib,
  ...
}: {
  imports = [
    ./minecraft.nix
  ];
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  home-manager.users.bunny.programs.tmux.terminal = lib.mkForce "xterm";

  services.static-web-server = {
    enable = true;
    listen = "[::]:80";
    root = ../../../extrafiles/http;
  };
}

