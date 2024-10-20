{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking.firewall.allowedUDPPorts = [
    24454 # Simple Voice Chat
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers = {
      bunnyServer = {
        enable = true;
        autoStart = true;
        package = pkgs.paperServers.paper-1_20_1;
        jvmOpts = "-Xms4096M -Xmx4096M";
        whitelist = {
          TheKillerBunny = "1dcce150-0064-4905-879c-43ef64dd97d7";
          "4P5" = "584fb77d-5c02-468b-a5ba-4d62ce8eabe2";
          PoolloverNathan = "b0639a61-e7f9-4d5c-8078-d4e9b05d9e9c";
          GNamimates = "e4b91448-3b58-4c1f-8339-d40f75ecacc4";
          AuriaFoxGirl = "93ab815f-92ab-4ea0-a768-c576896c52a8";
        };
        serverProperties = {
          enable-command-block = true;
          server-port = 25565;
          difficulty = "hard";
          gamemode = "creative";
          max-players = 10;
          level-seed = "1234567";
          motd = "§bTheKillerBunny§7's §6Minecraft Server.\n§7Have a §agreat day!";
          white-list = true;
        };
        files = {
          "config/paper-world-defaults.yml" = ../../../extrafiles/paper-world-defaults.yml;
        };
        symlinks = {
          "plugins/ViaVersion/config.yml" = ../../../extrafiles/VIA-Config.yml;
          "plugins/ServerListPlus/ServerListPlus.yml" = ../../../extrafiles/ServerListPlus.yml;
          "plugins/MinecraftDashboard/accounts.yml" = ../../../extrafiles/mc-accounts.yml;
          "plugins/ServerListPlus.jar" = pkgs.fetchurl { url = "https://github.com/Minecrell/ServerListPlus/releases/download/3.5.0/ServerListPlus-3.5.0-Universal.jar"; sha256 = "sha256-D0FjUTQbMkLw1ldtJeqyHFJor8POi/1SPE+kO44BKEQ="; };
          "plugins/PlayIt.jar" = pkgs.fetchurl { url = "https://github.com/playit-cloud/playit-minecraft-plugin/releases/latest/download/playit-minecraft-plugin.jar"; sha256 = "sha256-NoFhXy7b/sDh8VjPUjN5BVQ+KL/GJIIjqYws1Fh+GJI="; };
          "plugins/CoreProtect.jar" = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Lu3KuzdV/versions/llmrc4cl/CoreProtect-22.4.jar"; sha256 = "sha256-Ly+hxZU0SwcXakYfPlPhTqiEBxngkr7gUg1744CsPlU="; };
          "plugins/SimpleVoiceChat.jar" = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/h0gk30sM/voicechat-bukkit-2.5.24.jar"; sha256 = "sha256-aPkx9Wpc9Zkmg2twWU98NpQuHNv12HI0p2lsV4y4wLY="; };
          "plugins/ViaVersion.jar" = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P1OZGk5p/versions/R6MNWQmm/ViaVersion-5.0.3.jar"; sha256 = "sha256-INTyYb1/VFGB0RHhMLPy4vH9RUXpZju0ZM8nC0DhnXg="; };
          "plugins/MCDash.jar" = pkgs.fetchurl { url = "https://github.com/gnmyt/MCDash/releases/download/v1.1.7/MCDash-1.1.7.jar"; sha256 = "sha256-7a/99HzfxAxbaePBB4gPbT0cjYnc33+u975SO95hRfA="; };
          "ops.json" = pkgs.writeTextFile {
            name = "ops.json";
            text = builtins.toJSON [
              {
                uuid = "1dcce150-0064-4905-879c-43ef64dd97d7";
                name = "TheKillerBunny";
                level = 4;
                bypassPlayerLimit = true;
              }
              {
                uuid = "584fb77d-5c02-468b-a5ba-4d62ce8eabe2";
                name = "4P5";
                level = 4;
                bypassPlayerLimit = false;
              }
              {
                uuid = "b0639a61-e7f9-4d5c-8078-d4e9b05d9e9c";
                name = "PoolloverNathan";
                level = 4;
                bypassPlayerLimit = false;
              }
              {
                uuid = "e4b91448-3b58-4c1f-8339-d40f75ecacc4";
                name = "GNamimates";
                level = 4;
                bypassPlayerLimit = false;
              }
              {
                uuid = "93ab815f-92ab-4ea0-a768-c576896c52a8";
                name = "AuriaFoxGirl";
                level = 4;
                bypassPlayerLimit = false;
              }
            ];
          };
        };
      };
    };
  };
}

