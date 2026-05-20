{ pkgs, sp, ... }:
pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-macos";
  version = sp.applicationMetadata.version;
  src = sp.projectFiles;

  meta = {
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };

  nativeBuildInputs = sp.buildTools;

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    export HOME="$NIX_BUILD_TOP"
    export XDG_CONFIG_HOME="$HOME/.config"
    export PUB_CACHE="$HOME/pubcache"
    export GEM_HOME="$HOME/gemcache"
    export FLUTTER_ROOT="${sp.ourFlutter}"
    export LANG="en_US.UTF-8"

    export DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
    export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"

    export FLUTTER_BUILD_DIRECTORY="$HOME/deriveddata"
    export FLUTTER_NO_ANALYTICS="1"
    export CI="true"

    mkdir $HOME/builddir $PUB_CACHE
    lndir -silent ${sp.flutterDeps}/pubcache $PUB_CACHE
    lndir -silent $src $HOME/builddir
    rm -rf $HOME/builddir/{macos,build,pubspec.{lock,yaml}}
    cp -r ${sp.flutterDeps}/pubspec.{lock,yaml} $HOME/builddir/
    cp -r $src/macos $HOME/builddir/
    cp -r ${sp.cocoaMacosDeps}/cocoapods $HOME/.cocoapods
    chmod -R a+w $HOME/builddir/macos
    cp -r ${sp.cocoaMacosDeps}/macos/Pods $HOME/builddir/macos/
    chmod -R a+w $HOME/builddir/macos $HOME/.cocoapods

    pushd $HOME/builddir
    flutter config --no-analytics
    flutter config --enable-macos-desktop
    flutter pub get --offline --enforce-lockfile

    mkdir macos/scripts
    cp ${sp.cocoaLipoScript} macos/scripts/lipo
    patch -p1 < ${sp.cocoaMacosLipoPatch}

    # Build without signing (thus, without relying on /usr/bin/codesign)
    cat >> macos/Runner/Configs/Release.xcconfig << EOF
    CODE_SIGNING_ALLOWED=NO
    CODE_SIGNING_REQUIRED=NO
    CODE_SIGN_IDENTITY=
    AD_HOC_CODE_SIGNING_ALLOWED=NO
    EOF

    flutter build macos --release --no-pub
    popd
  '';

  installPhase = ''
    mkdir -p $out

    cp -r $HOME/builddir/build/macos/Build/Products/Release/*.app $out/
  '';
}
