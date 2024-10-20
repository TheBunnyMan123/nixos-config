{...}: {
  imports = [
    ./minecraft.nix
  ];
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.static-web-server = {
    enable = true;
    listen = "[::]:80";
    root = ../../../extrafiles/http;
  };
}

