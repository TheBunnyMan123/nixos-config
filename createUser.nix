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
  config,
  homeStateVersion,
  ...
}: {
  config = {
    users.users.${name} = {
      imports = [extraConfig];
      config = {
        isNormalUser = !systemUser;
        extraGroups = groups ++ (if canSudo then ["wheel"] else []);

        inherit home;
        inherit description;
        inherit packages;
        inherit hashedPassword;
        inherit shell;
        inherit uid;
      };
    };

    home-manager.users.${name} = {
      imports = [extraHomeConfig];
      #config.home.stateVersion = homeStateVersion;
    };
  };
}
