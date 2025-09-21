{ 
  lib, 
  stdenv, 
  fetchzip, 
  autoPatchelfHook,
  pkgs
}:

stdenv.mkDerivation {
  name = "ce-toolchain";

  src = fetchzip {
     sha256 = "sha256-+aElSupk3Sa6K2qixvfIECp6chd0kn+AWG8RHkQKPos=";
     url = "https://github.com/CE-Programming/toolchain/releases/download/v13.0/CEdev-Linux.tar.gz";
  };

  buildInputs = with pkgs; [ libz zstd libtinfo libgcc stdenv.cc.cc.lib ];
  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir $out
    cp $src/* $out -r
  '';
}

