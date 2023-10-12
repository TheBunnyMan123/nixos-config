{
  fetchFromGitHub,
  stdenv,
  pkgs
}:
 
stdenv.mkDerivation rec {
  name = "EliverLara/Sweet GTK Theme";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Sweet";
    rev = "v${version}";
    sha256 = "sha256-51LUSyY6gFRfnXH+4MXDSPL+fSPblsCUTg2r0odVnIE=";
  };

  installPhase = ''
    mkdir $out/share/themes/Sweet/ -p
    cp -r ./* $out/share/themes/Sweet/
  '';
}

