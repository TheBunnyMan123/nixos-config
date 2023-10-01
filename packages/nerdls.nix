{
  fetchFromGitHub,
  buildDotnetModule
}:
 
 buildDotnetModule rec {
  name = "nerdls";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-xC2GqNcFlEQyJr0iseRx+B59FGbKgbdHEj9RoS+GeM0=";
  };

  nugetDeps = ./deps-nerdls.nix;
  projectFile = "nerdls.csproj";
}

