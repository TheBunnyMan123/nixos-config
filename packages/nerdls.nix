{
  fetchFromGitHub,
  buildDotnetModule
 }:
 
 buildDotnetModule rec {
  name = "nerdls";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-Nxduete9bGMtBI61o341WI7qRrT/Jj/jRX0PpDwJAVw=";
  };

  nugetDeps = ./deps-nerdls.nix;
  projectFile = "nerdls.csproj";
}

