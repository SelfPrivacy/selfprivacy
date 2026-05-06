{ pkgs, sp, lib, ... }:

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
      FLUTTER_NO_ANALYTICS=1
      CI=true
      export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

      mkdir "$PUB_CACHE"
      lndir -silent "${sp.flutterDeps}" "$PUB_CACHE"

      #cp -r "${sp.cocoaIosDeps}/ios" "$HOME/"
      cp -r "${sp.cocoaIosDeps}/cocoapods" "$HOME/.cocoapods"
      chmod -R u+r "$HOME/.cocoapods"

      flutter config --no-analytics &>/dev/null
      flutter config --enable-ios &>/dev/null
      flutter pub get --offline --enforce-lockfile

      # Build without signing (thus, without relying on /usr/bin/codesign)
      cat >> ios/Runner/Configs/Release.xcconfig << EOF
      CODE_SIGNING_ALLOWED=NO
      CODE_SIGNING_REQUIRED=NO
      CODE_SIGN_IDENTITY=
      AD_HOC_CODE_SIGNING_ALLOWED=NO
      EOF

      flutter build "$1" --"$2" --no-codesign --no-pub
    '';
  };
in
pkgs.stdenv.mkDerivation rec {
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
