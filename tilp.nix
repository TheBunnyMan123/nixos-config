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
  pname = "tilp2";
  name = "tilp2";

  src = fetchurl {
    url = "mirror://sourceforge/tilp/${name}-1.18.tar.bz2";
    sha256 = "0isf73bjwk06baz2gm3vpdh600gqck9ca4aqxzb089dmxriv6fkv";
  };

  patches = fetchpatch {
    name = "remove-broken-kde-support.patch";
    url = "https://aur.archlinux.org/cgit/aur.git/plain/remove-broken-kde-support.patch?h=tilp";
    sha256 = "1fn6vh7r45spkwpmkvffkbn7zrcsdrs5mjmspd5rwi3jc12cy3ny";
  };
  
  nativeBuildInputs = [  
    pkg-config 
    intltool
    autoreconfHook
  ];
  
  buildInputs = [ 
    pkgs.libticalcs2 
    pkgs.libtifiles2 
    pkgs.libticonv 
    pkgs.libticables2 
    pkgs.glib 
    pkgs.gtk2 
    pkgs.rPackages.GFM ];
}
