{ 
  appimageTools, 
  fetchurl
}:

appimageTools.wrapType2 { # or wrapType1
  name = "TurboWarp";

  src = fetchurl {
    url = "https://github.com/TurboWarp/desktop/releases/download/v1.9.3/TurboWarp-linux-x86_64-1.9.3.AppImage";
    hash = "sha256-ERwX4UtAe/lsnfcglfThUjYwjxHLsqJ3yTZC3TRNGzc=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}