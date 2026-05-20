{
  pkgs,
  sp,
  lib,
  ...
}:

let
  iosBuildScript = pkgs.writeShellApplication {
    name = "ios-build-script";

    runtimeInputs = with pkgs; [
      sp.ourFlutter
      sp.ourFlutter.dart
      lndir
      mktemp
    ];

    text = ''
      shopt -s extglob

      TYPE="$1"
      RELEASE="$2"

      if [ "$#" -ne 2 ]; then
        echo "Error: Exactly 2 arguments are required: TYPE and RELEASE. But you provided $#"
        exit 1
      fi

      if [[ -z "$TYPE" || -z "$RELEASE" ]]; then
        echo "Error: Arguments can't be empty strings"
        exit 1
      fi

      if [[ ! "$TYPE" == @(ios|ipa)  ]]; then
          echo "Error: $TYPE is not a valid Android target type. Use either ios or ipa"
          exit 1
      fi

      if [[ ! "$RELEASE" == @(release|debug)  ]]; then
          echo "Error: $RELEASE is not a valid Android release type. Use either release or debug"
          exit 1
      fi

      HOME="$(mktemp -d)"
      XDG_CONFIG_HOME="$HOME/.config"
      PUB_CACHE="$HOME/pubcache"
      GEM_HOME="$HOME/gemcache"
      export HOME XDG_CONFIG_HOME PUB_CACHE GEM_HOME

      FLUTTER_BUILD_DIRECTORY="$HOME/builddir"
      FLUTTER_NO_ANALYTICS="1"
      CI="true"
      export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

      mkdir "$HOME/builddir" "$PUB_CACHE"
      lndir -silent "${sp.flutterDeps}/pubcache" "$PUB_CACHE"
      lndir -silent "${sp.projectFiles}" "$HOME/builddir"
      rm -rf "$HOME"/builddir/{ios,build,pubspec.{lock,yaml}}
      cp -r ${sp.flutterDeps}/pubspec.{lock,yaml} "$HOME/builddir/"
      cp -r ${sp.projectFiles}/ios "$HOME/builddir/"
      cp -r "${sp.cocoaIosDeps}/cocoapods" "$HOME/.cocoapods"
      chmod -R a+w "$HOME/builddir/ios"
      cp -r ${sp.cocoaIosDeps}/ios/Pods "$HOME/builddir/ios/"
      chmod -R a+w "$HOME/builddir/ios" "$HOME/.cocoapods"

      pushd "$HOME/builddir"
      flutter config --no-analytics
      flutter config --enable-ios
      flutter pub get --offline --enforce-lockfile

      mkdir ios/scripts
      cp ${sp.cocoaLipoScript} ios/scripts/lipo
      patch -p1 < ${sp.cocoaIosLipoPatch}

      flutter build "$1" --"$2" --no-codesign --no-pub
      popd
    '';
  };
in
pkgs.stdenvNoCC.mkDerivation rec {
  name = "build-ios";
  phases = [ "installPhase" ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${iosBuildScript}/bin/${iosBuildScript.name} $out/bin/${name}
    chmod +x $out/bin/${name}

    wrapProgram $out/bin/${name} \
      --set DEVELOPER_DIR "${sp.ourXcode}/Contents/Developer" \
      --prefix PATH : "${sp.ourXcode}/Contents/Developer/usr/bin/" \
      --prefix PATH : "${lib.makeBinPath sp.buildTools}"
  '';
}
