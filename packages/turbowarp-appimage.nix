{ 
  appimageTools, 
  fetchurl,
  # makeDesktopItem,
  # copyDesktopItems
}:

let 
  pname = "TurboWarp";
  version = "1.12.3";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://github.com/TurboWarp/desktop/releases/download/v${version}/TurboWarp-linux-x86_64-${version}.AppImage";
    name = "${name}.AppImage";
    hash = "sha256-5mPLnUzc3vxkv+QfkmOte1bvS59pODhELxt9mjwW2Iw=";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 { # or wrapType1
  inherit name src;

  # extraPkgs = pkgs: with pkgs; [ ];
# cd env-vars
  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/turbowarp-desktop.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/turbowarp-desktop.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname} --use-gl=desktop'
    cp -r ${appimageContents}/usr/share/* $out/share
  '';
}