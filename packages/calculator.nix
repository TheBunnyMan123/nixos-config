{ 
  appimageTools, 
  fetchurl
}:

appimageTools.wrapType2 { # or wrapType1
  name = "Calculator";
  src = fetchurl {
    url = "https://github.com/TheBunnyMan123/Calculator/releases/download/v1.0.1/Calculator-x86_64.AppImage";
    hash = "sha256-JVXq3ByYf96dkU1nxA3tJvI+gIv71/wfrWA7cUGqQ9I=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}