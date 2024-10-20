{
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [ "--ssh" "--advertise-exit-node" "--accept-dns=false" ];
    authKeyFile = pkgs.writeTextFile {
      name = "tailscale-key";
      text = "tskey-auth-kLYmJ1kfwb11CNTRL-EceifYchdHAfpYuZPU7xHApWnSp9hPm6K";
    };

    openFirewall = true;
  };

#  systemd.services.setprivCopy = {
#    enable = true;
#
#    wantedBy = ["multi-user.target"];
#
#    path = with pkgs; [ bash busybox ];
#    serviceConfig = {
#      ExecStart = ''
#        mkdir -p /home/1000/.local/bin
#        chown bunny /home/bunny/.local/bin
#        sudo rm /home/bunny/.local/bin/setpriv
#        sudo cp ${pkgs.busybox}/bin/setpriv /home/bunny/.local/bin/setpriv
#        sudo chown root /home/bunny/.local/bin/setpriv
#        sudo chmod u+s,a+x /home/bunny/.local/bin/setpriv
#     '';
#    };
#  };

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
  };
}
