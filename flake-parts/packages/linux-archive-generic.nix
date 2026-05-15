{ pkgs, sp, ... }:

pkgs.stdenv.mkDerivation {
  name = "${sp.applicationMetadata.name}-archive-generic";
  version = sp.applicationMetadata.version;

  nativeBuildInputs = sp.archiveTools;

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    mkdir -p vendor/usr/share/{applications,metainfo,icons} vendor/usr/share/icons/hicolor/{scalable,512x512}/apps/
    cp -r ${sp.applicationGeneric}/* vendor/
    cp ${sp.desktopFile} vendor/usr/share/applications/org.selfprivacy.app.desktop
    cp ${sp.appstreamFile} vendor/usr/share/metainfo/org.selfprivacy.app.metainfo.xml
    cp ${sp.iconPNGFile} vendor/usr/share/icons/hicolor/512x512/apps/org.selfprivacy.app.png
    cp ${sp.iconSVGFile} vendor/usr/share/icons/hicolor/scalable/apps/org.selfprivacy.app.svg
    chmod -R +rw vendor/
  '';

  installPhase = ''
    mkdir -p $out

    tar --sort=name --mtime="1970-01-01 00:00Z" --owner=0 --group=0 --numeric-owner \
        --pax-option="exthdr.name=%d/PaxHeaders/%f",delete=atime,delete=ctime \
        -cvf "${sp.applicationMetadata.name}-${sp.applicationMetadata.version}-generic.tar.xz" -C vendor/ .
    cp "${sp.applicationMetadata.name}-${sp.applicationMetadata.version}-generic.tar.xz" $out/
  '';
}
