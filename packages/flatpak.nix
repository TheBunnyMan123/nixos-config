

{ 
  lib, 
  stdenv
}:

stdenv.mkDerivation {
  stdenv.mkDerivation {
    name = "declarativeFlatpak";
    buildInputs = [ flatpak yes ];
    installPhase = ''
      yes | flatpak install com.github.tchx84.Flatseal org.gnome.Extensions org.gtk.Gtk3theme.Adwaita-dark org.prismlauncher.PrismLauncher org.turbowarp.TurboWarp
      yes | flatpak
    '';
    }
}