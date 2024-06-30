{
  name,
  description ? "",
  hashedPassword,
  shell ? pkgs: pkgs.bashInteractive,
  canSudo ? false,
  systemUser ? false,
  packages ? [],
  home,
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
      extraGroups = groups ++ (if canSudo then ["wheel"] else []);

      inherit home;
      inherit description;
      inherit packages;
      inherit hashedPassword;
      inherit shell;
      inherit uid;
    } // extraConfig;
  };
}
