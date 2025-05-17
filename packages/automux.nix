{ 
  lib, 
  stdenv, 
  pkgs
}:

stdenv.mkDerivation {
  name = "automux";
  
  src = ../extrafiles/automux;

  propagatedBuildInputs = with pkgs; [ makeWrapper coreutils dialog bashInteractive ];

  installPhase = ''
    mkdir -p $out/bin
    cp code.sh $out/bin/automux-code
    chmod +x $out/bin/automux-code
  '';
}

