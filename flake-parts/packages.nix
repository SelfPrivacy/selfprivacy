{ ... }:
{
  perSystem =
    {
      pkgs,
      sp,
      inputs',
      lib,
      ...
    }:
    {
      packages =
        with pkgs;
        {
          default = sp.applicationNix;

          flutter-deps = callPackage ./packages/flutter-deps.nix { inherit sp; };

          linux-nix = callPackage ./packages/linux-nix.nix { inherit sp; };
          linux-generic = callPackage ./packages/linux-generic.nix { inherit sp; };
          linux-portable = callPackage ./packages/linux-portable.nix { inherit sp; };
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

          macos = callPackage ./packages/macos.nix { inherit sp; };
          macos-cocoa-deps = callPackage ./packages/macos-cocoa-deps.nix { inherit sp; };

          #ios = callPackage ./packages/ios.nix { inherit sp; };
          ios-cocoa-deps = callPackage ./packages/linux-nix.nix { inherit sp; };
        }
        // (
          let
            androidTypes = [
              "apk"
              "aab"
            ];
            androidReleases = [
              "release"
              "debug"
            ];
            androidFlavors = [
              "production"
              "fdroid"
              "nightly"
            ];

            androidCombinations = lib.attrsets.cartesianProduct {
              type = androidTypes;
              release = androidReleases;
              flavor = androidFlavors;
            };
          in
          builtins.listToAttrs (
            map (c: {
              name = "android-${c.type}-${c.release}-${c.flavor}";
              value = pkgs.callPackage ./packages/android.nix {
                inherit sp;
                androidType = c.type;
                androidRelease = c.release;
                androidFlavor = c.flavor;
              };
            }) androidCombinations
          )
        );
    };
}
