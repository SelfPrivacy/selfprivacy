{
  pkgs,
  sp,
  androidType,
  androidRelease,
  androidFlavor,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-android-${androidType}-${androidRelease}-${androidFlavor}";
  version = sp.applicationMetadata.version;
  src = sp.projectFiles;

  meta = {
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };

  nativeBuildInputs = sp.buildTools ++ sp.androidBuildTools;

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    export HOME="$NIX_BUILD_TOP"
    export PUB_CACHE="$HOME/pubcache"
    export FLUTTER_ROOT="$HOME/flutter"
    export GRADLE_USER_HOME="$HOME/gradle"
    export MAVEN_REPO="${sp.androidGradleDeps}"

    export JAVA_HOME="${sp.ourJava.home}"
    export ANDROID_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
    export ANDROID_SDK_ROOT="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
    export ANDROID_NDK_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/ndk"
    export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2"

    mkdir $PUB_CACHE
    lndir -silent ${sp.flutterDeps} $PUB_CACHE

    mkdir $FLUTTER_ROOT
    lndir -silent ${sp.ourFlutter} $FLUTTER_ROOT

    if [[ "${androidRelease}" == "release" ]]; then
      export SP_AB_RELEASE="Release"
    elif [[ "${androidRelease}" == "debug" ]]; then
      export SP_AB_RELEASE="Debug"
    fi

    if [[ "${androidFlavor}" == "production" ]]; then
      export SP_AB_FLAVOR="Production"
    elif [[ "${androidFlavor}" == "fdroid" ]]; then
      export SP_AB_FLAVOR="Fdroid"
    elif [[ "${androidFlavor}" == "nightly" ]]; then
      export SP_AB_FLAVOR="Nightly"
    fi

    if [[ "${androidType}" == "apk" ]]; then
      export SP_AB_TYPE="assemble"
      export SP_AB_TYPE_PATH="apk"
      export SP_AB_RELEASE_PATH="${androidFlavor}/${androidRelease}"
    elif [[ "${androidType}" == "aab" ]]; then
      export SP_AB_TYPE="bundle"
      export SP_AB_TYPE_PATH="bundle"
      export SP_AB_RELEASE_PATH="${androidFlavor}$SP_AB_RELEASE"
    fi

    echo "Building: $SP_AB_TYPE$SP_AB_FLAVOR$SP_AB_RELEASE"
    echo "in build/app/outputs/$SP_AB_TYPE_PATH/$SP_AB_RELEASE_PATH/"

    mkdir $HOME/builddir
    lndir -silent $src $HOME/builddir
    rm -rf $HOME/builddir/android
    cp -r $src/android $HOME/builddir/
    chmod -R u+w $HOME/builddir/android

    pushd $HOME/builddir
    flutter config --no-analytics
    flutter config --enable-android
    flutter pub get --offline --enforce-lockfile
    popd

    pushd $HOME/builddir/android
    gradle --offline --no-daemon --no-watch-fs -I offline.gradle "$SP_AB_TYPE$SP_AB_FLAVOR$SP_AB_RELEASE" -Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2
    popd
  '';

  installPhase = ''
    mkdir -p $out
    cp $HOME/builddir/build/app/outputs/$SP_AB_TYPE_PATH/$SP_AB_RELEASE_PATH/*.${androidType} $out/
  '';
}
