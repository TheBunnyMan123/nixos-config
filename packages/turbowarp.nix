{ 
  lib, 
  stdenv, 
  fetchFromGitHub, 
  pkgs,
  autoPatchelfHook
}:

stdenv.mkDerivation rec {
  name = "TurboWarp";
  version = "1.9.3";

  src = fetchurl {
    url = "https://github.com/TurboWarp/desktop/releases/download/v${version}/TurboWarp-linux-x64-${version}.tar.gz";
    sha256 = "";
  };

  # buildInputs = [ imlib2 xorg.libX11.dev ];

  installPhase = ''
    autoPatchelf .

    ls
  '';
#    mkdir -p $out/bin
#    cp icat $out/bin
#  '';
}

