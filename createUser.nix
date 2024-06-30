{
  name,
  description ? "",
  hashedPassword,
  shell ? pkgs: pkgs.bashInteractive,
  canSudo ? false,
  systemUser ? false,
  packages ? pkgs: with pkgs; [zsh neovim nano coreutils-full],
  groups ? [],
  uid,
  extraConfig ? {},
  linger ? false
}: args@{
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    users.users.${name} = {
      isNormalUser = !systemUser;
      home = "/home/${name}";
      extraGroups = groups ++ (if canSudo then ["wheel"] else []);

      inherit description;
      inherit packages;
      inherit hashedPassword;
      inherit shell;
      inherit uid;
    } // extraConfig;
  };
}
