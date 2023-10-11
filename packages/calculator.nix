{
  fetchFromGitHub,
  buildDotnetModule,
  pkgs
}:
 
 buildDotnetModule rec {
  name = "calculator";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-2igzSEE8wqdYW/4CR1JpWJY4f+WcMtz0OtFiZUtr8t4=";
  };

  runtimeDeps = [ pkgs.fontconfig pkgs.xorg.libX11 pkgs.xorg.libICE pkgs.xorg.libSM ];

  nugetDeps = ./deps-calc.nix;
  projectFile = "Calculator.csproj";
}

