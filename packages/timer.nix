{ 
  appimageTools, 
  fetchurl
}:

appimageTools.wrapType2 { # or wrapType1
  name = "Timer";
  src = fetchurl {
    url = "https://github.com/TheBunnyMan123/Timer/releases/download/v1.0.0/Timer-x86_64.AppImage";
    hash = "sha256-ERwX4UtAe/lsnfcglfThUjYwjxHLsqJ3yTZC3TRNGzc=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}