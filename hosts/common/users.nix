{
  pkgs,
  inputs,
  createUser,
  ...
}: {
  users.mutableUsers = false;

  createUser {
    name = "root";
    hashedPassword = "$y$j9T$2fn61ZNkFqA9SC..wecPl/$mB/FcaC8bt04pMYQJy8GFXXF/wmt1Z7OWmjetmDP4B6";
    shell = pkgs.bash;
    systemUser = true;
    uid = 0;
  }

  createUser {
    name = "bunny";
    hashedPassword = "$y$j9T$2fn61ZNkFqA9SC..wecPl/$mB/FcaC8bt04pMYQJy8GFXXF/wmt1Z7OWmjetmDP4B6";
    shell = pkgs.zsh;
    canSudo = true;
    groups = ["networkmanager" "libvirtd" "docker" "adbusers"];
    systemUser = false;
    uid = 1000;
    description = "TheKillerBunny / TheBunnyMan123";
    linger = true;

    packages = with pkgs; [
      zsh
      coreutils-full
      (callPackage ../packages/icat.nix { })
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
      jdk21
    ];
  }
}
