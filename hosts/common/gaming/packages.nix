{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    steam
    lutris
  ];
}
