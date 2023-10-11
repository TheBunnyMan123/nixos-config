{ 
  lib, 
  stdenv, 
  fetchurl, 
  cmake, 
  pkg-config, 
  fetchpatch, 
  autoreconfHook,
  intltool,
  pkgs ? import <nixpkgs> { }
}:

stdenv.mkDerivation rec {
  desktopItems = [
    (
      pkgs.makeDesktopItem {
        name = "calculator";
        desktopName = "Calculator";
        exec = "Calculator";
        terminal = false;
      }

    )
    (
      pkgs.makeDesktopItem {
        name = "timer";
        desktopName = "Timer";
        exec = "Timer";
        terminal = false;
      }
    )
  ];

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = "icons";
    rev = "v1";
    sha256 = "";
  };

  icons
  installPhase = ''
    mkdir -p $out/share/icons

    copyDesktopItems

    cp ./Accessories-calculator.svg $out/share/icons/
    cp ./Accessories-timer.svg $out/share/icons/
}
