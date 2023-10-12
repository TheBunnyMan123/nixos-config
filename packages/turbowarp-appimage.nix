{ 
  appimageTools, 
  fetchurl
}:

appimageTools.wrapType2 { # or wrapType1
  name = "TurboWarp";

  src = fetchurl {
    url = "https://github.com/TurboWarp/desktop/releases/download/v1.9.3/TurboWarp-linux-x86_64-1.9.3.AppImage";
    hash = "sha256-PI8vAQtAoMKXPELper9SPgVJL8q+rU8JEWu1VUVPKkY=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}