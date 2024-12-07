{ 
  lib, 
  stdenv, 
  fetchzip,
  pkgs
}:

stdenv.mkDerivation {
  name = "remote";
  
  src = fetchzip {
    url = "https://gist.github.com/TheBunnyMan123/bddf298020e55fdfb32726c37af2129b/archive/0b69139dcd16e4f595129672a0fcb1d0b0c5b22e.zip";
    hash = "sha256-lAoAp4GjLCdm10FID3tv4Z6/XQK1VMiafIFU2TYs5pw=";
  };

  propagatedBuildInputs = with pkgs; [ sshfs bashInteractive ];

  installPhase = ''
    mkdir -p $out/bin
    sed -i 's:sshfs:${pkgs.sshfs}/bin/sshfs:g' remote
    cp remote $out/bin/remote
    chmod +x $out/bin/remote
  '';
}
