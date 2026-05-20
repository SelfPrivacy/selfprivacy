{
  pkgs,
  sp,
  ...
}:

# Darwin packages and runnables
pkgs.stdenvNoCC.mkDerivation {
  pname = "${sp.applicationMetadata.name}-macos-cocoa-deps";
  version = sp.applicationMetadata.version;
  src = sp.projectFiles;

  meta = {
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  nativeBuildInputs = sp.buildTools;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-13CX2YgE6xuj58G3R8p1qud5rindddhdshZTPlj8RmE=";

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

    mkdir -p $HOME/builddir $PUB_CACHE $GEM_HOME
    lndir -silent ${sp.flutterDeps}/pubcache $PUB_CACHE

    pushd $HOME/builddir
    cp -r $src/macos .
    cp -r ${sp.flutterDeps}/pubspec.{lock,yaml} .
    chmod -R u+w macos

    flutter config --no-analytics
    flutter config --enable-macos-desktop --enable-ios
    flutter pub get --no-precompile --enforce-lockfile
    popd

    pushd $HOME/builddir/macos
    pod install
    rm Pods/Pods.xcodeproj/project.pbxproj
    popd
  '';

  installPhase = ''
    mkdir -p $out/macos

    cp -r $HOME/builddir/macos/Pods $out/macos/
    cp -r $HOME/.cocoapods $out/cocoapods
  '';
}
