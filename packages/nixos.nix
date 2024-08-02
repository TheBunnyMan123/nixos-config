{ 
  lib, 
  stdenv, 
  pkgs
}:

stdenv.mkDerivation {
  name = "power";
  
  src = ../extrafiles;

  propagatedBuildInputs = with pkgs; [ makeWrapper coreutils dialog bashInteractive ];

  installPhase = ''
    mkdir -p $out/bin
    cp nixos.sh $out/bin/nixos
    chmod +x $out/bin/nixos
  '';
}

