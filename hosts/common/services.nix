{
  pkgs,
  inputs,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.syncthing = {
    enable = true;
    user = "bunny";
    configDir = "/home/bunny/.config/syncthing";
  };

  services.avahi = {
    nssmdns4 = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.dconf.enable = true;

  services.sshd.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
