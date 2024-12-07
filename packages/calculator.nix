{
  fetchFromGitHub,
  buildDotnetModule,
  copyDesktopItems,
  pkgs
}:
 
 buildDotnetModule rec {
  name = "calculator";
  version = "1.0.2";

  desktopItems = [
    (
      pkgs.makeDesktopItem {
        name = "calculator";
        desktopName = "Calculator";
        exec = "Calculator";
        icon = "com.thekillerbunny.calculator";
        categories = [ "Utility" "X-GNOME-Utilities"];
        type="Application";
        terminal = false;
      }
    )
  ];

  src = fetchFromGitHub {
    owner = "TheBunnyMan123";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-2igzSEE8wqdYW/4CR1JpWJY4f+WcMtz0OtFiZUtr8t4=";
  };

  nativeBuildInputs = [ copyDesktopItems ];

  runtimeDeps = [ pkgs.fontconfig pkgs.xorg.libX11 pkgs.xorg.libICE pkgs.xorg.libSM ];

  nugetDeps = ./deps-calc.nix;
  projectFile = "Calculator.csproj";

  postInstall = ''
    mkdir -p $out/share/icons
    cp ./Assets/Accessories-calculator.svg $out/share/icons/com.thekillerbunny.calculator.svg
  '';
}

