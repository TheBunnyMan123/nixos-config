{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
    egl-wayland
  ];

  programs.adb.enable = true;
}
