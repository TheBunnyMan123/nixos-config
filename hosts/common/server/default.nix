{...}: {
  imports = [
    ./minecraft.nix
  ];
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}

