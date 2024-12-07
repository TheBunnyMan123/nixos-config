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

   boot.initrd.availableKernelModules = ["xt_mark" "xt_comment" "xt_multiport"];
   boot.initrd.kernelModules = ["xt_mark" "xt_comment" "xt_multiport"];
   boot.kernelModules = ["xt_mark" "xt_comment" "xt_multiport"];

   systemd.tmpfiles = {
      rules = [
         # Set public directory
         "d /public 0777 root root - -"
         # Set bunny and root allowed to write to /etc/nixos
         "A /etc/nixos - - - - user::rwx,user:bunny:rwx,group::rwx,mask::rwx,other::r-x"
      ];
   };

   services.printing = {
      enable = true;
      drivers = with pkgs; [ brlaser ];
      openFirewall = true;
   };

   services.syncthing = {
      enable = true;
      user = "bunny";
      configDir = "/home/bunny/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
   };

   services.avahi = {
      openFirewall = true;
      nssmdns4 = true;
      enable = true;
      ipv4 = true;
      ipv6 = true;
      publish = {
         enable = true;
         addresses = true;
         workstation = true;
         userServices = true;
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
