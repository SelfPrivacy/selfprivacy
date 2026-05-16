{ ... }:

{
  perSystem =
    {
      self',
      pkgs,
      sp,
      ...
    }:
    {
      devShells = {
        default =
          if pkgs.stdenvNoCC.isLinux then
            self'.devShells.linux
          else if pkgs.stdenvNoCC.isDarwin then
            self'.devShells.macos
          else
            throw "Unsupported operating system!";

        # Generic shells
        analyze = pkgs.mkShellNoCC { nativeBuildInputs = sp.analyzeTools; };

        scan = pkgs.mkShellNoCC { nativeBuildInputs = sp.scannerTools; };

        test = pkgs.mkShellNoCC { nativeBuildInputs = sp.testTools; };

        sign = pkgs.mkShellNoCC { nativeBuildInputs = sp.signTools; };

        fdroid = pkgs.mkShellNoCC { nativeBuildInputs = sp.fdroidTools; };

        # Linux shells
        linux-precached = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools;
          buildInputs = sp.buildLibs;

          shellHook = ''
            export HOME=$(mktemp -d)
            export PUB_CACHE="$HOME/pubcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE
          '';
        };

        linux = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools;
          buildInputs = sp.buildLibs;

          shellHook = ''
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"
          '';
        };

        linux-flatpak = pkgs.mkShell { nativeBuildInputs = sp.flatpakTools; };

        linux-appimage = pkgs.mkShellNoCC { nativeBuildInputs = sp.appimageTools; };

        # Android shells
        android-precached = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools ++ sp.androidBuildTools;

          shellHook = ''
            export HOME=$(mktemp -d)
            export PUB_CACHE="$HOME/pubcache"
            export FLUTTER_ROOT="$HOME/flutter"
            export GRADLE_USER_HOME="$HOME/gradle"
            export MAVEN_REPO="${sp.androidGradleDeps}"
            export ANDROID_SDK="${sp.ourAndroidSDK.androidsdk}"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"

            export JAVA_HOME="${sp.ourJava.home}"
            export ANDROID_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_SDK_ROOT="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_NDK_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/ndk"
            export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE

            mkdir $FLUTTER_ROOT
            lndir -silent ${sp.ourFlutter} $FLUTTER_ROOT
          '';
        };

        android = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools ++ sp.androidBuildTools;

          shellHook = ''
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"
            export JAVA_HOME="${sp.ourJava.home}"
            export ANDROID_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_SDK_ROOT="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_NDK_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/ndk"
            export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2"
          '';
        };

        # Darwin shells
        macos-precached = pkgs.mkShellNoCC {
          nativeBuildInputs = sp.buildTools;

          shellHook = ''
            export HOME="$(mktemp -d)"
            export PUB_CACHE="$HOME/pubcache"
            export GEM_HOME="$HOME/gemcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export LANG="en_US.UTF-8"

            export DEVELOPER_DIR="${sp.ourXcode}"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE
          '';
        };

        macos = pkgs.mkShellNoCC {
          nativeBuildInputs = sp.buildTools;

          shellHook = ''
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export LANG="en_US.UTF-8"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"

            export DEVELOPER_DIR="${sp.ourXcode}"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"
          '';
        };

        ios-precached = pkgs.mkShellNoCC {
          nativeBuildInputs = sp.buildTools;

          shellHook = ''
            export HOME="$(mktemp -d)"
            export PUB_CACHE="$HOME/pubcache"
            export GEM_HOME="$HOME/gemcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export LANG="en_US.UTF-8"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"
            export DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE
          '';
        };

        ios = pkgs.mkShellNoCC {
          nativeBuildInputs = sp.buildTools;

          shellHook = ''
            export FLUTTER_ROOT="${sp.ourFlutter}"
            export LANG="en_US.UTF-8"
            export FLUTTER_NO_ANALYTICS="1"
            export CI="true"
            export DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"
          '';
        };
      };
    };
}
