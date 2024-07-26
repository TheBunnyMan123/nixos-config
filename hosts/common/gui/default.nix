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
      noto-fonts-cjk
      noto-fonts-emoji
      corefonts
      nerdfonts
    ];
  };

  catppuccin = {
    flavor = "macchiato";
    accent = "blue";
    enable = true;
  };
}
