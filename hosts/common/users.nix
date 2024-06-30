{
  pkgs,
  inputs,
  createUser,
  ...
}: {
  users.mutableUsers = false;

  imports = [
    (
      createUser {
        name = "root";
        hashedPassword = "$y$j9T$r7Q60T/F48oyLnK8OnVXT.$cbSoNXPw3WbC9nW.nvQ5VpXYmwC3HmIuQoykavM4lGD";
        shell = pkgs.bash;
        systemUser = true;
        uid = 0;
        home = "/root";
        description = "System administrator";
        packages = with pkgs; [
          neovim
          coreutils-full
        ]
      }
    ) (
      createUser {
        name = "bunny";
        hashedPassword = "$y$j9T$yk.0wI1bKFcSByKp3QYZI/$xFSdjqnJygu4ut6NyY5bfIsBDPSoSrIoNATs9vVD29B";
        shell = pkgs.zsh;
        canSudo = true;
        groups = ["networkmanager" "libvirtd" "docker" "adbusers"];
        systemUser = false;
        uid = 1000;
        description = "TheKillerBunny / TheBunnyMan123";
        linger = true;
        home = "/home/bunny";
      
        packages = with pkgs; [
          zsh
          coreutils-full
          (callPackage ../../packages/icat.nix { })
          git
          ffmpeg
          fastfetch
          github-cli
          tmux
          neovim
          zoxide
          fzf
          stow
          eza
          bat
          w3m
          zoxide
          jdk21
          espeak-ng
        ];
      }
    )
  ];
}
