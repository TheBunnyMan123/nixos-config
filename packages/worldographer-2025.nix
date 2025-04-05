{ 
   pkgs ? import <nixpkgs>,
   stdenv,
   fetchurl,
   jre ? (pkgs.zulu17.override {enableJavaFX = true;}), # Recommended JRE for previous major worldographer version
   ...
}:

stdenv.mkDerivation rec {
   name = "worldographer-2025";

   src = fetchurl {
      url = "https://worldographer.com/releases/2025/Worldographer-2025-Beta-1.07.jar";
      sha256 = "sha256-jK6nvBfV+eZoT2lG6brbvInBp7ViCa+O5QM3va/0xsk=";
   };
   dontUnpack = true;
   dontBuilt = true;

   buildInputs = [
      jre # Recommended JRE for previous major worldographer version
   ];

   installPhase = ''
      mkdir -p "$out/bin"
      echo '#!/bin/bash' > "$out/bin/worldographer-2025"
      echo '"${jre}/bin/java" -Xmx4G -Dprism.maxvran=3G -jar ${src} $@' >> "$out/bin/worldographer-2025"
      chmod 755 "$out/bin/worldographer-2025"
   '';
}

