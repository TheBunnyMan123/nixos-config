{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  name = "protonhax";
  src = fetchFromGitHub {
    owner = "jcnils";
    repo = "protonhax";
    rev = "1.0.5";
    hash = "sha256-5G4MCWuaF/adSc9kpW/4oDWFFRpviTKMXYAuT2sFf9w=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp protonhax $out/bin
    chmod +x $out/bin/protonhax
  '';
}

