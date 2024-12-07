{
  pkgs,
  config,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [ "--advertise-exit-node" "--accept-dns=false" ];
    authKeyFile = pkgs.writeTextFile {
      name = "tailscale-key";
      text = "tskey-auth-kLYmJ1kfwb11CNTRL-EceifYchdHAfpYuZPU7xHApWnSp9hPm6K";
    };

    openFirewall = true;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    #xt_mark
    #xt_comment
    #xt_multiport
  ];
  boot.initrd.availableKernelModules = ["xt_mark" "xt_comment" "xt_multiport"];
  boot.initrd.kernelModules = ["xt_mark" "xt_comment" "xt_multiport"];
  boot.kernelModules = ["xt_mark" "xt_comment" "xt_multiport"];

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

   systemd.tmpfiles = {
      rules = [
         # Set public directory
         "d /public 0777 root root - -"
         # Set bunny and root allowed to write to /etc/nixos
         "A /etc/nixos - - - - user::rwx,user:bunny:rwx,group::rwx,mask::rwx,other::r-x"
      ];
   };

  services.syncthing = {
    enable = true;
    user = "bunny";
    configDir = "/home/bunny/.config/syncthing";
    guiAddress = "0.0.0.0:8384";
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
