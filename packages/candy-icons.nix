{
  fetchFromGitHub,
  buildDotnetModule,
  pkgs
}:
 
stdenv.mkDerivation rec {
  name = "EliverLara/Sweet GTK Theme";
  version = "3.0";

  src = fetchZip {
    url = "https://github.com/EliverLara/candy-icons/archive/bcf24f3308cc5e39f3e7d1bb43cb26f627f9ba8f.zip";
    sha256 = "";
  };

  installPhase = ''
    cp * $out/share/icons/candy-icons
  '';
}

