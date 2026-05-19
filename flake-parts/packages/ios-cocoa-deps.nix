{
  lib,
  pkgs,
  sp,
  ...
}:

pkgs.stdenvNoCC.mkDerivation {
  pname = "${sp.applicationMetadata.name}-ios-cocoa-deps";
  version = sp.applicationMetadata.version;
  src = ../../ios;

  meta = {
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  nativeBuildInputs = sp.buildTools;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-iRsTECtxnLH0haMwydYR4h67bPzgKcVtR7Hi8qasT3I=";

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

    export FLUTTER_NO_ANALYTICS="1"
    export CI="true"

    mkdir -p $HOME/builddir
    lndir -silent ${sp.flutterDeps}/pubcache $PUB_CACHE
    rm $HOME/builddir/pubspec.{lock,yaml}
    cp -r ${sp.flutterDeps}/pubspec.{lock,yaml} $HOME/builddir/

    pushd $HOME/builddir
    cp -r $src ios
    chmod -R u+w ios

    flutter config --no-analytics
    flutter config --enable-macos-desktop --enable-ios
    flutter pub get --no-precompile --enforce-lockfile

    mkdir ios/scripts
    cp ${sp.cocoaLipoScript} ios/scripts/lipo
    patch -p1 < ${sp.cocoaIosLipoPatch}
    popd

    mkdir $GEM_HOME
    pushd $HOME/ios
    pod install
    rm Pods/Pods.xcodeproj/project.pbxproj
    rm Flutter/flutter_export_environment.sh
    rm Flutter/Generated.xcconfig
    find . -type d \( -name .symlinks -o \
                      -name SpIcon.icon -o \
                      -name xcuserdata \) -exec rm -rf {} + || true
    find Flutter/ephemeral/ -type f -mindepth 1 -exec rm -f {} + || true
    popd
  '';

  installPhase = ''
    mkdir -p $out

    cp -r $HOME/ios $out/
    cp -r $HOME/.cocoapods $out/cocoapods
  '';
}
