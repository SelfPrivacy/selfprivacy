{
  config,
  lib,
  pkgs,
  sp,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-linux-portable";
  version = sp.applicationMetadata.version;

  nativeBuildInputs = with pkgs; [
    bubblewrap lndir patchelf
  ];

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    mkdir -p builddir/opt/{src,flutter}
    lndir -silent ${sp.buildroot} builddir
    lndir -silent ${sp.projectFiles} builddir/opt/src
    chmod -R a+w builddir/opt

    lndir -silent ${sp.ourFlutter.unwrapped} builddir/opt/flutter
    rm -rf builddir/opt/flutter/bin/cache
    mkdir -p builddir/opt/flutter/bin/cache
    lndir -silent ${sp.ourFlutter}/bin/cache builddir/opt/flutter/bin/cache

    mkdir builddir/opt/pubcache
    lndir -silent ${sp.flutterDeps} builddir/opt/pubcache

    bwrap --bind $(pwd)/builddir / --bind /nix/store /nix/store --dev /dev --proc /proc --tmpfs /tmp \
          --unshare-all --clearenv --setenv PATH /usr/bin:/usr/sbin:/sbin:/bin:/opt/flutter/bin:${sp.buildrootPixiUnpack}/bin \
          --setenv TMPDIR /tmp --die-with-parent /usr/bin/bash -c \
            'export HOME=$(mktemp -d) && export XDG_CONFIG_HOME=$HOME/.config && export DESTDIR=/opt/dest && \
            cd /opt && pixi-unpack ${sp.buildrootDeps}/deps.tar && source /opt/activate.sh && \
            ln -sr /opt/env/bin/clang-22 /opt/env/bin/clang && ln -sr /opt/env/bin/clang++-22 /opt/env/bin/clang++ && \
            cd /opt/src && export PUB_CACHE=/opt/pubcache && export FLUTTER_ROOT=/opt/flutter && export FLUTTER_NO_ANALYTICS=1 && \
            export CI=true && flutter config --no-analytics && flutter config --enable-linux-desktop && \
            flutter pub get --offline --enforce-lockfile && flutter build linux --release --no-pub && \
            cp $CONDA_PREFIX/lib/{*libgio*,*libglib*,*libgmodule*,*libiconv*,*libpcre*,*libsecret*} /opt/dest/opt/src/build/linux/x64/release/bundle/lib/'
  '';

  installPhase = ''
    mkdir -p $out

    cp -r $(pwd)/builddir/opt/dest/opt/src/build/linux/x64/release/bundle/. $out/
    mv $out/selfprivacy $out/org.selfprivacy.app

    patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../lib:$ORIGIN/../usr/lib:/usr/lib/x86_64-linux-gnu:/app/lib' $out/org.selfprivacy.app
    patchelf --set-interpreter '/lib64/ld-linux-x86-64.so.2' $out/org.selfprivacy.app
    for plib in "libdynamic_color_plugin.so" "libflutter_linux_gtk.so" "libflutter_secure_storage_linux_plugin.so" "liburl_launcher_linux_plugin.so"; do
     patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../lib:$ORIGIN/../usr/lib:/usr/lib/x86_64-linux-gnu:/app/lib' $out/lib/"$plib"
    done
  '';
}
