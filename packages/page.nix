{ 
  lib, 
  stdenv, 
  fetchzip,
  pkgs
}:

stdenv.mkDerivation {
  name = "remote";
  
  src = ../extrafiles;

  propagatedBuildInputs = with pkgs; [ bashInteractive ];

  installPhase = ''
    mkdir -p $out/bin
    cp page.sh $out/bin/page
    chmod +x $out/bin/page
  '';
}
