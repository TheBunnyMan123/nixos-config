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
  extraHomeConfig ? {},
  linger ? false
}: args@{
  pkgs,
  lib,
  config,
  homeStateVersion,
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

    home-manager.users.${name} = {
      home.stateVersion = homeStateVersion;
    } // extraHomeConfig;
  };
}
