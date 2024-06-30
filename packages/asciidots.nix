{
  pkgs,
  fetchFromGitHub,
  python3Packages,
  ...
}: python3Packages.buildPythonPackage rec {
  pname = "asciidots";
  name = "asciidots";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "aaronjanse";
    repo = name;
    rev = "${version}";
    sha256 = "sha256-+fwSDGlBLRSvnPH8GABrv0E25YaYTQEhnPcxOhH8u/U=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [ click ];
}
