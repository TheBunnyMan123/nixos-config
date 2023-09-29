{
  fetchFromGitHub,
  buildDotnetModule
}:
 
 buildDotnetModule rec {
  name = "nerdls";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-xDSzqKETgQ/g8C5O9SJ7PRsTKfLzBqOg4Ljb7bWWsT4=";
  };

  nugetDeps = ./deps-nerdls.nix;
  projectFile = "nerdls.csproj";
}

