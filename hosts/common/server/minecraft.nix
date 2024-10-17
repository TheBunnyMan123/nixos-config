{
  pkgs,
  inputs,
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
        jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
        whitelist = {
          TheKillerBunny = "1dcce150-0064-4905-879c-43ef64dd97d7";
        };
        serverProperties = {
          server-port = 25565;
          difficulty = "hard";
          gamemode = "creative";
          max-players = 10;
          level-seed = "1234567";
          motd = "\u00a7bTheKillerBunny\u00a77's \u00a76Minecraft\u00a77 Server!\nHave a \u00a7agreat\u00a77 day!";
          white-list = true;
        };
        symlinks = {
          "ops.json" = pkgs.writeTextFile {
            name = "ops.json";
            text = builtins.toJSON [
              {
                uuid = "1dcce150-0064-4905-879c-43ef64dd97d7";
                name = "TheKillerBunny";
                level = 4;
                bypassPlayerLimit = true;
              }
            ];
          };
          plugins = pkgs.linkFarmFromDrvs "plugins" (builtins.attrValues {
            SimpleVoiceChat = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/h0gk30sM/voicechat-bukkit-2.5.24.jar"; sha256 = "sha256-aPkx9Wpc9Zkmg2twWU98NpQuHNv12HI0p2lsV4y4wLY="; };
            LuckPerms = pkgs.fetchurl { url = "https://download.luckperms.net/1556/bukkit/loader/LuckPerms-Bukkit-5.4.141.jar"; sha256 = "sha256-hLfma0LghR74+MP5wwvMHRCCuVGYOs/DMrNtMmgDTQk="; };
            ViaVersion = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P1OZGk5p/versions/R6MNWQmm/ViaVersion-5.0.3.jar"; sha256 = "sha256-INTyYb1/VFGB0RHhMLPy4vH9RUXpZju0ZM8nC0DhnXg="; };
          });
        };
      };
    };
  };
}

