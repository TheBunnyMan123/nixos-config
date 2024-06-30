{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
  ];

  programs.adb.enable = true;
}
