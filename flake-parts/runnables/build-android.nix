{ pkgs, lib, sp, ... }:

let
  androidBuildScript = pkgs.writeShellApplication {
    name = "android-build-script";

    runtimeInputs = [
      sp.ourFlutter
      sp.ourFlutter.dart
    ];

    text = ''
      shopt -s extglob

      TYPE="$1"
      RELEASE="$2"
      FLAVOR="$3"

      if [ "$#" -ne 3 ]; then
        echo "Error: Exactly 3 arguments are required: TYPE, RELEASE, FLAVOR. But you provided $#"
        exit 1
      fi

      if [[ -z "$TYPE" || -z "$RELEASE" || -z "$FLAVOR" ]]; then
        echo "Error: Arguments can't be empty strings"
        exit 1
      fi

      if [[ ! "$TYPE" == @(apk|aab)  ]]; then
          echo "Error: $TYPE is not a valid Android target type. Use either apk or aab"
          exit 1
      fi

      if [[ ! "$RELEASE" == @(release|debug)  ]]; then
          echo "Error: $RELEASE is not a valid Android release type. Use either release or debug"
          exit 1
      fi

      if [[ ! "$FLAVOR" == @(production|fdroid|nightly)  ]]; then
          echo "Error: $FLAVOR is not a valid Android release type. Use either production, fdroid, or nightly"
          exit 1
      fi

      HOME="$(mktemp -d)"
      PUB_CACHE="$HOME/pubcache"
      export HOME PUB_CACHE

      FLUTTER_BUILD_DIRECTORY="$HOME/builddir"
      FLUTTER_NO_ANALYTICS=1
      CI=true
      export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

      mkdir "$PUB_CACHE"
      lndir -silent "${sp.flutterDeps}" "$PUB_CACHE"

      flutter config --no-analytics &>/dev/null
      flutter config --enable-android &>/dev/null
      flutter pub get --offline --enforce-lockfile
      flutter build "$1" --"$2" --flavor "$3" --no-pub
    '';
  };
in
pkgs.stdenv.mkDerivation rec {
  name = "build-android";
  phases = [ "installPhase" ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${androidBuildScript}/bin/${androidBuildScript.name} $out/bin/${name}
    chmod +x $out/bin/${name}

    wrapProgram $out/bin/${name} \
      --set JAVA_HOME "${sp.ourJava.home}" \
      --set ANDROID_HOME "${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk" \
      --set ANDROID_SDK_ROOT "${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk" \
      --set ANDROID_NDK_HOME "${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/ndk" \
      --prefix PATH : "${lib.makeBinPath (sp.buildTools ++ sp.buildLibs)}" \
      --prefix PKG_CONFIG_PATH : "${
        lib.makeSearchPathOutput "dev" "lib/pkgconfig" (sp.buildTools ++ sp.buildLibs)
      }" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath (sp.buildTools ++ sp.buildLibs)}"
  '';
}
