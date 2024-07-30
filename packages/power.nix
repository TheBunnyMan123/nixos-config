{ 
  lib, 
  stdenv, 
  fetchzip,
  pkgs
}:

stdenv.mkDerivation {
  name = "power";
  
  src = fetchzip {
    url = "https://gist.github.com/TheBunnyMan123/1117813c46720fc66b1ff8b602a5e09a/archive/ba8191e9baf3cf65a832eb2f57860b6d9b6f68ad.zip";
    hash = "sha256-N9cwuZPI1+Rq7w3881dSkJjbiCjA4GNivbHHr+RsERY=";
  };

  propagatedBuildInputs = with pkgs; [ makeWrapper coreutils dialog bashInteractive ];

  installPhase = ''
    mkdir -p $out/bin
    cp power.sh $out/bin/power-menu
    chmod +x $out/bin/power-menu
  '';

  postFixup = ''
    wrapProgram $out/bin/power-menu \
      --set PATH ${lib.makeBinPath(with pkgs; [
        bashInteractive
        toybox
        dialog
        systemd
      ])}
  '';
}
