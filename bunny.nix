{
   fok-quote,
   createUser,
   catppuccin,
   vencord
}:
{ 
   homeStateVersion,
   canSudo ? false,
   canTTY ? true,
   canViewJournal ? canSudo,
   linger ? true,
   gui ? false,
   home ? "/home/bunny",
   uid ? 1000
}: {
   pkgs,
   lib,
   ...
}: {
   home-manager.users.bunny.imports = [
     catppuccin.homeManagerModules.catppuccin
   ];

   imports = [(createUser {
      inherit canSudo canTTY canViewJournal linger home uid homeStateVersion;

      name = "bunny";
      hashedPassword = "$y$j9T$E4hYDO/sYjg3hYSTroc5W0$oTFU06Ubm0evVrs/rDlpxQF.RQe8bcBPwPsWxpSe8yC";
      shell = pkgs.zsh;
      groups = ["libvirtd" "docker" "adbusers"];
      systemUser = false;
      description = "TheKillerBunny / TheBunnyMan123";

      shellInitFile = pkgs.writeShellScript "bunny-shell-init.sh" ''
         PS1="[\u@\h: \w]$ "
      '';

      packages = with pkgs; [
         yazi
         coreutils-full
         (callPackage ./packages/icat.nix   { })
         (callPackage ./packages/remote.nix { })
         sshfs
         ffmpeg
         github-cli
         stgit
         fzf
         w3m
         discordo
         fok-quote.packages.${pkgs.system}.default
      ];

      extraHomeConfig = {
         imports = [ ./bunnyHome.nix ];
      };
   })] ++ lib.optional gui ./hosts/common/gui/gui-home.nix;
}

