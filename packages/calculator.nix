{ fetchFromGitHub
, buildDotnetModule
}:

buildDotnetModule rec {
  name = "Calculator";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "";
  };

  projectFile = "Calculator/Calculator.csproj"

  # meta = with lib; {
  #   homepage = "some_homepage";
  #   description = "some_description";
  #   license = licenses.mit;
  # };
}