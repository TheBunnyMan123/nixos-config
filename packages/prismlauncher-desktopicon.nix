{ 
  lib, 
  stdenv, 
  fetchFromGitHub, 
  imlib2, 
  xorg
}:

stdenv.mkDerivation {
  name = "prismlauncher-desktopicon";

  src = fetchFromGitHub {
    owner = "PrismLauncher";
    repo = "PrismLauncher";
    rev = version;
    sha256 = "sha256-RArg60S91YKp1Mt97a5JNfBEOf2cmuX4pK3VAx2WfqM=";
  };

  installPhase = ''
    cp share $out/share
  '';
}

