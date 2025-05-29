{
  lib,
  dcbot,
  ...
}: {
  imports = [
    ./minecraft.nix
  ];

   services.gitea = {
    enable = true;
   };
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

  systemd.services.discord-bot = {
     enable = true;
     after = [ "network-online.target" ];
     wants = [ "network-online.target" ];
     script = ''bash -c 'BOT_TOKEN="$(cat /srv/dc-bot-token)" ${dcbot}/bin/bunny_bot' '';
     user = "bunnybot";
     group = "bunnybot";

     restartIfChanged = true;
  };
}

