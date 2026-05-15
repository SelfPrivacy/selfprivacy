{ pkgs, sp, ... }:

pkgs.stdenv.mkDerivation {
  name = "${sp.applicationMetadata.name}-generic";
  version = sp.applicationMetadata.version;
  src = sp.projectFiles;

  meta = {
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };

  nativeBuildInputs = sp.buildTools;
  buildInputs = sp.buildLibs;

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    export HOME=$(mktemp -d)
    export XDG_CONFIG_HOME="$HOME/.config"
    export PUB_CACHE=$HOME/pubcache

    export FLUTTER_NO_ANALYTICS=1
    export CI=true

    mkdir $PUB_CACHE
    ln -s ${sp.flutterDeps}/* $PUB_CACHE/

    cp -r $src/. .
    chmod -R u+rw .

    flutter config --no-analytics &>/dev/null
    flutter config --enable-linux-desktop &>/dev/null
    flutter pub get --offline --enforce-lockfile
    flutter build linux --release --no-pub
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r build/linux/x64/release/bundle/* $out/

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
