{ pkgs, sp, lib, ... }:

let
  macosBuildScript = pkgs.writeShellApplication {
    name = "macos-build-script";

    runtimeInputs = with pkgs; [
      sp.ourFlutter
      sp.ourFlutter.dart
      lndir
      mktemp
    ];

    text = ''
      shopt -s extglob

      RELEASE="$1"

      if [ "$#" -ne 1 ]; then
        echo "Error: Exactly 1 argument is required: RELEASE. But you provided $#"
        exit 1
      fi

      if [[ -z "$RELEASE" ]]; then
        echo "Error: Arguments can't be empty strings"
        exit 1
      fi

      if [[ ! "$RELEASE" == @(release|debug)  ]]; then
          echo "Error: $RELEASE is not a valid macOS release type. Use either release or debug"
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

      #cp -r "${sp.cocoaMacosDeps}/macos" "$HOME/"
      cp -r "${sp.cocoaMacosDeps}/cocoapods" "$HOME/.cocoapods"
      chmod -R u+r "$HOME/.cocoapods"

      flutter config --no-analytics &>/dev/null
      flutter config --enable-macos-desktop &>/dev/null
      flutter pub get --offline --enforce-lockfile

      # Build without signing (thus, without relying on /usr/bin/codesign)
      cat >> macos/Runner/Configs/Release.xcconfig << EOF
      CODE_SIGNING_ALLOWED=NO
      CODE_SIGNING_REQUIRED=NO
      CODE_SIGN_IDENTITY=
      AD_HOC_CODE_SIGNING_ALLOWED=NO
      EOF

      flutter build macos --"$1" --no-pub
    '';
  };
in
pkgs.stdenv.mkDerivation rec {
  name = "build-macos";
  phases = [ "installPhase" ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${macosBuildScript}/bin/${macosBuildScript.name} $out/bin/${name}
    chmod +x $out/bin/${name}

    wrapProgram $out/bin/${name} \
      --set DEVELOPER_DIR "${sp.ourXcode}/Contents/Developer" \
      --prefix PATH : "${sp.ourXcode}/Contents/Developer/usr/bin/" \
      --prefix PATH : "${lib.makeBinPath sp.buildTools}"
  '';
}
