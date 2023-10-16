{
  fetchzip,
  stdenv,
  pkgs
}:
 
stdenv.mkDerivation rec {
  name = "EliverLara/Candy Icons";

  src = fetchzip {
    url = "https://github.com/EliverLara/candy-icons/archive/bcf24f3308cc5e39f3e7d1bb43cb26f627f9ba8f.zip";
    sha256 = "sha256-NCXxH04GvrPE5mQO7JrU6SkjA+BaZokhyjKsm8m9p3g=";
  };

  installPhase = ''
    mkdir $out/share/icons/candy-icons/ -p
    cp -r ./* $out/share/icons/candy-icons/
  '';
}

