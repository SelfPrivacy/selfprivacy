{ pkgs, sp, ... }:

pkgs.stdenv.mkDerivation {
  name = "${sp.applicationMetadata.name}-appimage";
  version = sp.applicationMetadata.version;

  nativeBuildInputs = (sp.appimageTools);

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    mkdir -p AppDir
    cp -r ${sp.applicationGeneric}/* AppDir/
    cp ${sp.desktopFile} AppDir/org.selfprivacy.app.desktop
    cp ${sp.appstreamFile} AppDir/org.selfprivacy.app.metainfo.xml
    cp ${sp.iconSVGFile} AppDir/org.selfprivacy.app.svg
    chmod -R u+rw AppDir/

    ln -sr AppDir/org.selfprivacy.app AppDir/AppRun
  '';

  installPhase = ''
    mkdir -p $out

    appimagetool --runtime-file $(which appimage-runtime) AppDir "${sp.applicationMetadata.name}-${sp.applicationMetadata.version}.AppImage"

    cp "${sp.applicationMetadata.name}-${sp.applicationMetadata.version}.AppImage" $out/
  '';
}
