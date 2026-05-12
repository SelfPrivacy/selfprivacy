{ ... }:

{
  perSystem =
    { pkgs, sp, ... }:
    {
      devShells = {
        # Generic shells
        analyze = pkgs.mkShell { nativeBuildInputs = sp.analyzeTools; };

        scan = pkgs.mkShell { nativeBuildInputs = sp.scannerTools; };

        test = pkgs.mkShell { nativeBuildInputs = sp.testTools; };

        sign = pkgs.mkShell { nativeBuildInputs = sp.signTools; };

        fdroid = pkgs.mkShell { nativeBuildInputs = sp.fdroidTools; };

        # Linux shells
        linux-precached = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools;
          buildInputs = sp.buildLibs;

          shellHook = ''
            export HOME=$(mktemp -d)
            export PUB_CACHE="$HOME/pubcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE

            mkdir $HOME/builddir
            lndir -silent ${sp.projectFiles} $HOME/builddir
            cd $HOME/builddir
          '';
        };

        linux = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools;
          buildInputs = sp.buildLibs;

          shellHook = ''
            export HOME=$(mktemp -d)
            export PUB_CACHE="$HOME/pubcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"
          '';
        };

        linux-flatpak = pkgs.mkShell {
          nativeBuildInputs = sp.flatpakTools;

          shellHook = ''
            export HOME=$(mktemp -d)
          '';
        };

        linux-appimage = pkgs.mkShell {
          nativeBuildInputs = sp.appimageTools;

          shellHook = ''
            export HOME=$(mktemp -d)
          '';
        };

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

            export JAVA_HOME="${sp.ourJava.home}"
            export ANDROID_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_SDK_ROOT="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_NDK_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/ndk"
            export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/build-tools/35.0.0/aapt2"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE

            mkdir $FLUTTER_ROOT
            lndir -silent ${sp.ourFlutter} $FLUTTER_ROOT
            # rm -rf $FLUTTER_ROOT/bin
            # cp -r ${sp.ourFlutter}/bin $FLUTTER_ROOT/
            # chmod -R u+w $FLUTTER_ROOT/bin

            mkdir $HOME/builddir
            lndir -silent ${sp.projectFiles} $HOME/builddir
            rm -rf $HOME/builddir/android
            cp -r ${sp.projectFiles}/android $HOME/builddir/
            chmod -R u+w $HOME/builddir/android
            cd $HOME/builddir
          '';
        };

        android = pkgs.mkShell {
          nativeBuildInputs = sp.buildTools ++ sp.androidBuildTools;

          shellHook = ''
            export HOME=$(mktemp -d)
            export PUB_CACHE="$HOME/pubcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"

            export JAVA_HOME="${sp.ourJava.home}"
            export ANDROID_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_SDK_ROOT="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_NDK_HOME="${sp.ourAndroidSDK.androidsdk}/libexec/android-sdk/ndk"
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

            export DEVELOPER_DIR="${sp.ourXcode}"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE

            mkdir $HOME/builddir
            lndir -silent ${sp.projectFiles} $HOME/builddir
            rm -rf $HOME/builddir/macos $HOME/builddir/build
            #cp -r ${sp.cocoaMacosDeps}/macos $HOME/builddir/
            cp -r ${sp.cocoaMacosDeps}/cocoapods $HOME/.cocoapods
            chmod -R u+w $HOME/builddir/macos $HOME/.cocoapods
            cd $HOME/builddir
          '';
        };

        macos = pkgs.mkShellNoCC {
          nativeBuildInputs = sp.buildTools;

          shellHook = ''
            export HOME="$(mktemp -d)"
            export PUB_CACHE="$HOME/pubcache"
            export GEM_HOME="$HOME/gemcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"

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

            export DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"

            mkdir $PUB_CACHE
            lndir -silent ${sp.flutterDeps} $PUB_CACHE

            mkdir $HOME/builddir
            lndir -silent ${sp.projectFiles} $HOME/builddir
            rm -rf $HOME/builddir/ios $HOME/builddir/build
            #cp -r ${sp.cocoaIosDeps}/ios $HOME/builddir/
            cp -r ${sp.cocoaIosDeps}/cocoapods $HOME/.cocoapods
            chmod -R u+w $HOME/builddir/ios $HOME/.cocoapods
            cp -r ${sp.projectFiles}/ios/SpIcon.icon $HOME/builddir/ios/
            chmod -R u+w $HOME/builddir/ios/SpIcon.icon
            cd $HOME/builddir
          '';
        };

        ios = pkgs.mkShellNoCC {
          nativeBuildInputs = sp.buildTools;

          shellHook = ''
            export HOME="$(mktemp -d)"
            export PUB_CACHE="$HOME/pubcache"
            export GEM_HOME="$HOME/gemcache"
            export FLUTTER_ROOT="${sp.ourFlutter}"

            export DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
            export PATH="${sp.ourXcode}/Contents/Developer/usr/bin/:$PATH"
          '';
        };
      };
    };
}
