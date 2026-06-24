{ pkgs, sp, ... }:

pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-appimage-portable";
  version = sp.applicationMetadata.version;

  meta = {
    platforms = [ "x86_64-linux" ];
  };

  nativeBuildInputs = sp.appimageTools;

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    mkdir -p AppDir
    cp -r ${sp.applicationPortable}/. AppDir/
    cp ${sp.desktopFile} AppDir/selfprivacy.desktop
    cp ${sp.appstreamFile} AppDir/selfprivacy.metainfo.xml
    cp ${sp.iconSVGFile} AppDir/selfprivacy.svg
    chmod -R u+rw AppDir/

    ln -sr AppDir/selfprivacy AppDir/AppRun
  '';

  installPhase = ''
    mkdir -p $out

    appimagetool --runtime-file $(which appimage-runtime) AppDir "${sp.applicationMetadata.name}-${sp.applicationMetadata.version}-portable.AppImage"

    cp "${sp.applicationMetadata.name}-${sp.applicationMetadata.version}-portable.AppImage" $out/
  '';
}
