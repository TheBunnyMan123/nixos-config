{
  config,
  pkgs,
  inputs,
  createUser,
  fok-quote,
  homeStateVersion,
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
        ];
        extraHomeConfig = {
          home.stateVersion = homeStateVersion;
        };
      }
    )

    ../../bunny.nix
  ];

  environment.pathsToLink = [ "/share/zsh" ];
}
