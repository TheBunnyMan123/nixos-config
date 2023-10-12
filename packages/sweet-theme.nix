{
  fetchFromGitHub,
  buildDotnetModule,
  pkgs
}:
 
stdenv.mkDerivation rec {
  name = "EliverLara/Sweet GTK Theme";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Sweet";
    rev = "v${version}";
    sha256 = "sha256-6M2b+VxPgWy3oPQygKQ2z+JYoGy2YxL9l1iyd78eOHI=";
  };

  installPhase = ''
    cp * $out/share/themes/Sweet
  '';
}

