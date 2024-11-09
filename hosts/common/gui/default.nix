{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
    ./gui-home.nix
  ];

  boot.plymouth = {
    enable = true;
  };

  fileSystems."/home/bunny/.config/vesktop/settings" = {
    device = "/home/bunny/.config/Vencord/settings";
    options = [ "bind" ];
  };

  fileSystems."/home/bunny/.config/vesktop/themes" = {
    device = "/home/bunny/.config/Vencord/themes";
    options = [ "bind" ];
  };

  security.pam.services.hyprlock = {};

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "MesloLGS Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Color Emoji"
          "MesloLGS Nerd Font"
        ];
        serif = [
          "Noto Serif"
          "Noto Color Emoji"
          "MesloLGS Nerd Font"
        ];
      };
    };

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      corefonts
      nerdfonts
    ];
  };

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    enable = true;
  };
}
