{
  fetchFromGitHub,
  buildDotnetModule,
  copyDesktopItems,
  pkgs
}:
 
 buildDotnetModule rec {
  name = "timer";
  version = "1.0.1";

  desktopItems = [
    (
      pkgs.makeDesktopItem {
        name = "timer";
        desktopName = "Timer";
        exec = "Timer";
        icon = "com.thekillerbunny.timer";
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
    sha256 = "sha256-6M2b+VxPgWy3oPQygKQ2z+JYoGy2YxL9l1iyd78eOHI=";
  };

  nativeBuildInputs = [ copyDesktopItems ];

  runtimeDeps = [ pkgs.fontconfig pkgs.xorg.libX11 pkgs.xorg.libICE pkgs.xorg.libSM ];

  nugetDeps = ./deps-timer.nix;

  projectFile = "Timer.csproj";

  postInstall = ''
    mkdir -p $out/share/icons
    cp ./Assets/Accessories-timer.svg $out/share/icons/com.thekillerbunny.timer.svg
  '';
}

