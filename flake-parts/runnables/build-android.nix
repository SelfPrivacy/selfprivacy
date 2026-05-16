{
  pkgs,
  lib,
  sp,
  ...
}:

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

      if [[ "$RELEASE" == "release" ]]; then
        SP_AB_RELEASE="Release"
        export SP_AB_RELEASE
      elif [[ "$RELEASE" == "debug" ]]; then
        SP_AB_RELEASE="Debug"
        export SP_AB_RELEASE
      fi

      if [[ "$FLAVOR" == "production" ]]; then
        SP_AB_FLAVOR="Production"
        export SP_AB_FLAVOR
      elif [[ "$FLAVOR" == "fdroid" ]]; then
        SP_AB_FLAVOR="Fdroid"
        export SP_AB_FLAVOR
      elif [[ "$FLAVOR" == "nightly" ]]; then
        SP_AB_FLAVOR="Nightly"
        export SP_AB_FLAVOR
      fi

      if [[ "$TYPE" == "apk" ]]; then
        SP_AB_TYPE="assemble"
        SP_AB_TYPE_PATH="apk"
        SP_AB_RELEASE_PATH="$FLAVOR/$RELEASE"
        export SP_AB_TYPE SP_AB_TYPE_PATH SP_AB_RELEASE_PATH
      elif [[ "$TYPE" == "aab" ]]; then
        SP_AB_TYPE="bundle"
        SP_AB_TYPE_PATH="bundle"
        SP_AB_RELEASE_PATH="$FLAVOR$SP_AB_RELEASE"
        export SP_AB_TYPE SP_AB_TYPE_PATH SP_AB_RELEASE_PATH
      fi

      echo "Building: $SP_AB_TYPE$SP_AB_FLAVOR$SP_AB_RELEASE"
      echo "in build/app/outputs/$SP_AB_TYPE_PATH/$SP_AB_RELEASE_PATH/"

      HOME="$(mktemp -d)"
      PUB_CACHE="$HOME/pubcache"
      GRADLE_USER_HOME="$HOME/gradle"
      MAVEN_REPO="${sp.androidGradleDeps}"
      export HOME PUB_CACHE GRADLE_USER_HOME MAVEN_REPO

      FLUTTER_BUILD_DIRECTORY="$HOME/builddir"
      FLUTTER_NO_ANALYTICS=1
      CI=true
      export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

      mkdir "$PUB_CACHE"
      lndir -silent "${sp.flutterDeps}" "$PUB_CACHE"

      flutter config --no-analytics
      flutter config --enable-android
      flutter pub get --offline --enforce-lockfile
      flutter build "$1" --"$2" --flavor "$3" --no-pub

      pushd "$(pwd)/android"
      gradle --offline --no-daemon --no-watch-fs -I offline.gradle "$SP_AB_TYPE$SP_AB_FLAVOR$SP_AB_RELEASE" -Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2
      popd
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
      --set GRADLE_OPTS "-Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2" \
      --prefix PATH : "${lib.makeBinPath (sp.buildTools ++ sp.buildLibs ++ sp.androidBuildTools)}" \
      --prefix PKG_CONFIG_PATH : "${
        lib.makeSearchPathOutput "dev" "lib/pkgconfig" (
          sp.buildTools ++ sp.buildLibs ++ sp.androidBuildTools
        )
      }" \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath (sp.buildTools ++ sp.buildLibs ++ sp.androidBuildTools)
      }"
  '';
}
