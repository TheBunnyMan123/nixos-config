{
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";

    openFirewall = true;
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

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = lib.mkForce "no";
    # extraConfig = ''
      # Match User sftp
      # ChrootDirectory /var/lib/sftp
    # '';
  };

  # fileSystems."/var/lib/sftp/nix" = {
  #   device = "/nix";
  #   options = ["bind"];
  # };
  # fileSystems."/var/lib/sftp/run" = {
  #   device = "/run";
  #   options = ["bind"];
  # };
}
