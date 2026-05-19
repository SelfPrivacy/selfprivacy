{ pkgs, sp, ... }:

pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-generic";
  version = sp.applicationMetadata.version;

  src = sp.projectFiles;

  meta = {
    platforms = [ "x86_64-linux" ];
  };

  nativeBuildInputs = sp.buildTools;
  buildInputs = sp.buildLibs;

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    export HOME="$NIX_BUILD_TOP"
    export XDG_CONFIG_HOME="$HOME/.config"
    export PUB_CACHE="$HOME/pubcache"

    export FLUTTER_NO_ANALYTICS="1"
    export CI="true"

    mkdir $HOME/builddir
    lndir -silent $src $HOME/builddir

    mkdir $PUB_CACHE
    lndir -silent ${sp.flutterDeps}/pubcache $PUB_CACHE
    rm $HOME/builddir/pubspec.{lock,yaml}
    cp -r ${sp.flutterDeps}/pubspec.{lock,yaml} $HOME/builddir/

    pushd $HOME/builddir
    flutter config --no-analytics
    flutter config --enable-linux-desktop
    flutter pub get --offline --enforce-lockfile
    flutter build linux --release --no-pub
    popd
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r $HOME/builddir/build/linux/x64/release/bundle/* $out/

    patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../lib:$ORIGIN/../usr/lib:/usr/lib/x86_64-linux-gnu:/app/lib' $out/selfprivacy
    patchelf --set-interpreter '/lib64/ld-linux-x86-64.so.2' $out/selfprivacy
    for plib in "libdynamic_color_plugin.so" "libflutter_linux_gtk.so" "libflutter_secure_storage_linux_plugin.so" "liburl_launcher_linux_plugin.so"; do
      patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../lib:$ORIGIN/../usr/lib:/usr/lib/x86_64-linux-gnu:/app/lib' $out/lib/"$plib"
    done

    mv $out/selfprivacy $out/org.selfprivacy.app
    ln -sr $out/org.selfprivacy.app $out/bin/org.selfprivacy.app
  '';

  meta = {
    mainProgram = "org.selfprivacy.app";
  };
}
