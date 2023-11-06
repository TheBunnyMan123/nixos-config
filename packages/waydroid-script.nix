{ stdenv
, lib
, python311Packages
, fetchFromGitHub
, substituteAll
, lzip
, util-linux
, nix-update-script
}:
let
  name = "waydroid-script";
  version = "unstable-2023-09-26";
  src = fetchFromGitHub {
    repo = "waydroid_script";
    owner = "casualsnek";
    rev = "acbb764ac56f113add58598ecbe22801f8250d8b";
    hash = "sha256-oEVTruu4l7vtk2kXEuK3m30g75uZzWDoQgKVNeBg7+4=";
  };

  resetprop = stdenv.mkDerivation {
    pname = "resetprop";
    inherit version src;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share
      cp -r bin/* $out/share/
    '';
  };
in python311Packages.buildPythonApplication rec {
  inherit name version src;

  propagatedBuildInputs = with python311Packages; [
    inquirerpy
    requests
    tqdm

    lzip
    util-linux
  ];

  postPatch = let
    setup = substituteAll {
      src = ./setup.py;
      inherit pname;
      desc = meta.description;
      version = builtins.replaceStrings [ "-" ] [ "." ]
        (lib.strings.removePrefix "unstable-" version);
    };
  in ''
    ln -s ${setup} setup.py

    substituteInPlace stuff/general.py \
      --replace "os.path.dirname(__file__), \"..\", \"bin\"," "\"${resetprop}/share\","
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };
}