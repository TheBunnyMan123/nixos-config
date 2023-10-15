

  {
  fetchzip,
  stdenv,
  pkgs
}:
 
stdenv.mkDerivation rec {
  name = "EliverLara/Sweet GTK Theme";
  version = "3.0";

  src = fetchzip {
    url = "https://github.com/EliverLara/candy-icons/archive/bcf24f3308cc5e39f3e7d1bb43cb26f627f9ba8f.zip";
    sha256 = "sha256-NCXxH04GvrPE5mQO7JrU6SkjA+BaZokhyjKsm8m9p3g=";
  };

  nativeBuildInputs = [ pkgs.inkscape pkgs.xcursorgen ];

  buildPhase = ''
    cd kde
    cd cursors
    bash ./build.sh
    ls
    cp esswer eww
  '';

  installPhase = ''
    cd kde
    cd cursors
    mkdir $out/share/icons
	  cp eSweet-cursors $out/share/icons
  '';
}

