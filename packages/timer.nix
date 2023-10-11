{
  fetchFromGitHub,
  buildDotnetModule,
  pkgs
}:
 
 buildDotnetModule rec {
  name = "timer";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-6M2b+VxPgWy3oPQygKQ2z+JYoGy2YxL9l1iyd78eOHI=";
  };

  runtimeDeps = [ pkgs.fontconfig pkgs.xorg.libX11 pkgs.xorg.libICE pkgs.xorg.libSM ];

  nugetDeps = ./deps-timer.nix;

  projectFile = "Timer.csproj";
}

