{
  pkgs,
  lib,
  systemStateVersion,
  homeStateVersion,
  createUser,
  ...
}: {
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wlp4s0";
      enableIPv6 = true;
    };
    networkmanager.unmanaged = [ "interface-name:ve-*" ];
  };

  containers.sftp = {
    autoStart = true;
    privateNetwork = false;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    bindMounts = {
      "/upload" = {
        hostPath = "/sftp";
        isReadOnly = false;
      };
    };

    config = { config, pkgs, lib, stateVersion, ... }: {
      users.mutableUsers = false;
      users.groups.sftp = {};
      users.users.root = {
        hashedPassword = "$y$j9T$r7Q60T/F48oyLnK8OnVXT.$cbSoNXPw3WbC9nW.nvQ5VpXYmwC3HmIuQoykavM4lGD";
        isNormalUser = false;
        uid = 0;
        home = "/root";
        description = "System administrator";
      };
      users.users.sftp = {
        hashedPassword = "$y$j9T$BejZDD5/cGX.8MD1jza7./$Pw1nQKOMHo0LZSShkS1P8ezp8G1bVZOKBQ2wFtW/Sw.";
        isNormalUser = false;
        group = "sftp";
        uid = 1;
        home = "/home/sftp";
        description = "SFTP User";
        createHome = true;
        shell = pkgs.bash;
      };

      system.activationScripts.permissions.text = ''
        mkdir /upload
        chmod 777 /upload
      '';

      services.openssh = {
        enable = true;
        settings.PermitRootLogin = lib.mkForce "no";
        ports = [ 2222 ];
        extraConfig = ''
          Match group sftp
            X11Forwarding no
            AllowTcpForwarding no
            AllowAgentForwarding no
            ForceCommand internal-sftp -d /upload
        '';
      };

      system.stateVersion = systemStateVersion;

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 2222 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };

  containers.bunny-sshsworthy-test = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    bindMounts = {
      "/upload" = {
        hostPath = "/sftp";
        isReadOnly = false;
      };
    };

    config = { outputs, config, pkgs, lib, stateVersion, ... }: {
      imports = [
        outputs.nixosModules.bunny-sshworthy
      ];

      system.stateVersion = systemStateVersion;

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 80 443 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };
}
