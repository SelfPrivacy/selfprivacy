{
  config,
  lib,
  pkgs,
  sp,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-linux-generic-portable";
  version = sp.applicationMetadata.version;

  nativeBuildInputs = with pkgs; [
    bubblewrap
  ];

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-nop1MU7dCaqDig/1w/gxZwJc6oj0dZl9dCzPvuDIhq0=";

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    cp -r ${sp.buildroot} builddir
    chmod -R +w builddir
    mkdir -p builddir/opt
    cp -r ${sp.buildrootToolkit}/.pixi builddir/opt/
    cp -r ${sp.buildrootToolkit}/rattler builddir/opt/
    cp -r ${sp.projectFiles} builddir/opt/src
    chmod -R +w builddir/opt/src

    mkdir -p builddir/opt/flutter
    cp -r ${sp.buildrootFlutter}/. builddir/opt/flutter
    chmod -R +w builddir/opt/flutter

    cp -r ${sp.flutterDeps} builddir/opt/pubcache
    chmod -R +w builddir/opt/pubcache

    bwrap --bind $(pwd)/builddir / --dev /dev --proc /proc --tmpfs /tmp --unshare-all --share-net \
          --setenv PATH /usr/bin:/usr/sbin:/sbin:/bin --setenv TMPDIR /tmp --die-with-parent bash -c \
            'export HOME=$(mktemp -d) && export PIXI_CACHE_DIR=/opt/rattler/cache && export DESTDIR=/opt/dest && \
            cd /opt && source <(/opt/pixi shell-hook) && cd /opt/src && export PUB_CACHE=/opt/pubcache && \
            export FLUTTER_NO_ANALYTICS=1 && export CI=true && /opt/flutter/bin/flutter config --no-analytics && \
            /opt/flutter/bin/flutter config --enable-linux-desktop && /opt/flutter/bin/flutter pub get --offline --enforce-lockfile && \
            /opt/flutter/bin/flutter build linux --release --no-pub'
  '';

  installPhase = ''
    mkdir -p $out

    cp -r $(pwd)/builddir/opt/dest/. $out/
  '';
}
