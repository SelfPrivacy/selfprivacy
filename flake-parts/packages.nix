{ ... }:
{
  perSystem =
    {
      pkgs,
      sp,
      inputs',
      ...
    }:
    {
      packages = with pkgs; {
        default = sp.applicationNix;

        flutter-deps = callPackage ./packages/flutter-deps.nix { inherit sp; };

        linux-nix = callPackage ./packages/linux-nix.nix { inherit sp; };
        linux-generic = callPackage ./packages/linux-generic.nix { inherit sp; };
        linux-generic-portable = callPackage ./packages/linux-generic-portable.nix { inherit sp; };
        linux-flatpak = callPackage ./packages/linux-flatpak.nix { inherit sp; };
        linux-flatpak-sdk = callPackage ./packages/linux-flatpak-sdk.nix { inherit sp; };
        linux-appimage = callPackage ./packages/linux-appimage.nix { inherit sp; };
        linux-archive = callPackage ./packages/linux-archive.nix { inherit sp; };

        linux-buildroot = callPackage ./packages/linux-buildroot.nix { inherit sp; };
        linux-buildroot-deps = callPackage ./packages/linux-buildroot-deps.nix { };
        linux-buildroot-toolkit = callPackage ./packages/linux-buildroot-toolkit.nix { inherit sp; };

        android-gradle-deps = inputs'.gradle2nix.packages.gradle2nix.buildMavenRepo {
          lockFile = ../android/gradle.lock;
        };
        android-apk-release-production = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "apk";
          androidRelease = "release";
          androidFlavor = "production";
        };
        android-apk-debug-production = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "apk";
          androidRelease = "debug";
          androidFlavor = "production";
        };
        android-apk-release-fdroid = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "apk";
          androidRelease = "release";
          androidFlavor = "fdroid";
        };
        android-apk-debug-fdroid = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "apk";
          androidRelease = "debug";
          androidFlavor = "fdroid";
        };
        android-apk-release-nightly = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "apk";
          androidRelease = "release";
          androidFlavor = "nightly";
        };
        android-apk-debug-nightly = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "apk";
          androidRelease = "debug";
          androidFlavor = "nightly";
        };
        android-aab-release-production = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "aab";
          androidRelease = "release";
          androidFlavor = "production";
        };
        android-aab-debug-production = callPackage ./packages/android.nix {
          inherit sp;
          androidType = "aab";
          androidRelease = "debug";
          androidFlavor = "production";
        };

        macos = callPackage ./packages/macos.nix { inherit sp; };
        macos-cocoa-deps = callPackage ./packages/macos-cocoa-deps.nix { inherit sp; };

        #ios = callPackage ./packages/ios.nix { inherit sp; };
        ios-cocoa-deps = callPackage ./packages/linux-nix.nix { inherit sp; };
      };
    };
}
