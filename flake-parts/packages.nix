{ inputs, ... }:
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
          linux-appimage-generic = callPackage ./packages/linux-appimage-generic.nix { inherit sp; };
          linux-appimage-portable = callPackage ./packages/linux-appimage-portable.nix { inherit sp; };
          linux-archive-generic = callPackage ./packages/linux-archive-generic.nix { inherit sp; };
          linux-archive-portable = callPackage ./packages/linux-archive-portable.nix { inherit sp; };

          linux-buildroot = callPackage ./packages/linux-buildroot.nix { inherit sp; };
          linux-buildroot-deps = callPackage ./packages/linux-buildroot-deps.nix { inherit sp; };

          android-gradle-deps = inputs'.gradle2nix.packages.gradle2nix.buildMavenRepo {
            lockFile = ../android/gradle.lock;
          };

          macos = callPackage ./packages/macos.nix { inherit sp; };
          macos-cocoa-deps = callPackage ./packages/macos-cocoa-deps.nix { inherit sp; };

          #ios = callPackage ./packages/ios.nix { inherit sp; };
          ios-cocoa-deps = callPackage ./packages/ios-cocoa-deps.nix { inherit sp; };
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
                # Nightly's versionCode is `git rev-list --count HEAD`, which
                # Nix exposes as inputs.self.revCount when the flake source is
                # a clean git tree. On a dirty tree revCount is unset; fail
                # loudly here rather than silently shipping versionCode = -1.
                # Other flavors don't read this value (they use pubspec.yaml's
                # +N), so default to "" for them.
                versionCode =
                  if c.flavor == "nightly" then
                    toString (
                      inputs.self.revCount or (throw
                        "android-${c.type}-${c.release}-nightly: cannot evaluate inputs.self.revCount — the flake source is a dirty git tree. Commit your changes (or check out a clean ref) before building nightly artifacts."
                      )
                    )
                  else
                    "";
              };
            }) androidCombinations
          )
        )
        // (
          let
            nfpmTypes = [
              "rpm"
              "deb"
              "archlinux"
            ];

            nfpmCombinations = lib.attrsets.cartesianProduct {
              type = nfpmTypes;
            };
          in
          builtins.listToAttrs (
            map (c: {
              name = "linux-nfpm-${c.type}";
              value = pkgs.callPackage ./packages/linux-nfpm.nix {
                inherit sp;
                nfpmType = c.type;
              };
            }) nfpmCombinations
          )
        );
    };
}
