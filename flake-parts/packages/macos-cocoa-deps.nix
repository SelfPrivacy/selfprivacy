{
  lib,
  pkgs,
  sp,
  ...
}:

# Darwin packages and runnables
pkgs.stdenvNoCC.mkDerivation {
  pname = "${sp.applicationMetadata.name}-macos-cocoa-deps";
  version = sp.applicationMetadata.version;
  # FIXME: Add the macOS target
  src = (lib.fileset.maybeMissing ../../macos);

  meta = {
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  nativeBuildInputs = sp.buildTools;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-ueNGV7XYUEHtOipkJ7SzdXQ2JqSCOX1xpZ84ycp+LpE=";

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    export HOME="$NIX_BUILD_TOP"
    export XDG_CONFIG_HOME="$HOME/.config"
    export PUB_CACHE="$HOME/pubcache"
    export GEM_HOME="$HOME/gemcache"
    export LANG="en_US.UTF-8"

    export FLUTTER_NO_ANALYTICS=1
    export CI=true

    mkdir -p $HOME/builddir
    lndir -silent ${sp.flutterDeps}/pubcache $PUB_CACHE
    cp -r ${sp.flutterDeps}/pubspec.{lock,yaml} $HOME/builddir/

    pushd $HOME/builddir
    cp -r $src macos
    chmod -R u+w macos

    flutter config --no-analytics
    flutter config --enable-macos-desktop --enable-ios
    flutter pub get --no-precompile --enforce-lockfile

    mkdir macos/scripts
    cp ${sp.cocoaLipoScript} macos/scripts/lipo
    patch -p1 < ${sp.cocoaMacosLipoPatch}
    popd

    mkdir $GEM_HOME
    pushd $HOME/macos
    pod install
    rm Pods/Pods.xcodeproj/project.pbxproj
    find . -type d \( -name .symlinks -o \
                      -name xcuserdata \) -exec rm -rf {} + || true
    find Flutter/ephemeral/ -type f -mindepth 1 -exec rm -f {} + || true
    popd
  '';

  installPhase = ''
    mkdir -p $out

    cp -r $HOME/macos $out/
    cp -r $HOME/.cocoapods $out/cocoapods
  '';
}
