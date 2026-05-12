{
  lib,
  pkgs,
  sp,
  ...
}:

pkgs.stdenv.mkDerivation {
  pname = "${sp.applicationMetadata.name}-ios-cocoa-deps";
  version = sp.applicationMetadata.version;
  src = lib.fileset.toSource {
    root = ../../.;
    fileset = lib.fileset.unions [
      ../../pubspec.yaml
      ../../pubspec.lock
      ../../ios/
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
    export HOME=$(mktemp -d)
    export XDG_CONFIG_HOME="$HOME/.config"
    export PUB_CACHE="$HOME/pubcache"
    export GEM_HOME="$HOME/gemcache"
    export LANG="en_US.UTF-8"

    export FLUTTER_NO_ANALYTICS=1
    export CI=true

    mkdir $PUB_CACHE
    lndir -silent ${sp.flutterDeps} $PUB_CACHE

    pushd $HOME
    cp -r $src/ios .
    cp $src/pubspec.yaml .
    cp $src/pubspec.lock .
    chmod -R u+w ios

    flutter config --no-analytics &>/dev/null
    flutter config --enable-macos-desktop --enable-ios &>/dev/null
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
    find Flutter/ephemeral/ -type -f -mindepth 1 -exec rm -f {} + || true
    popd
  '';

  installPhase = ''
    mkdir -p $out

    cp -r $HOME/ios $out/
    cp -r $HOME/.cocoapods $out/cocoapods
  '';
}
