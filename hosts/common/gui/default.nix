{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
  ];

   programs.dconf.enable = true;

  boot.plymouth = {
    enable = true;
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
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-color-emoji
      corefonts
      vista-fonts
    ] ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts));
  };

  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    enable = true;
  };
}
