{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./services.nix
  ];

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono"
          "Noto Color Emoji"
          "FiraCode"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Color Emoji"
          "FiraCode"
        ];
        serif = [
          "Noto Serif"
          "Noto Color Emoji"
          "FiraCode"
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
}
