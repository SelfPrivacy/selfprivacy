{ ... }:
{
  perSystem = { pkgs, sp, ... }: {
    packages = with pkgs; {
      default = sp.applicationNix;

      flutter-deps = callPackage ./packages/flutter-deps.nix { inherit sp; };

      linux-nix = callPackage ./packages/linux-nix.nix { inherit sp; };
      linux-generic = callPackage ./packages/linux-generic.nix { inherit sp; };
      linux-flatpak = callPackage ./packages/linux-flatpak.nix { inherit sp; };
      linux-flatpak-sdk = callPackage ./packages/linux-flatpak-sdk.nix { inherit sp; };
      linux-appimage = callPackage ./packages/linux-appimage.nix { inherit sp; };
      appimagetool = callPackage ./packages/appimagetool.nix { inherit sp; };
      appimage-runtime = callPackage ./packages/appimage-runtime.nix { inherit sp; };
      linux-archive = callPackage ./packages/linux-archive.nix { inherit sp; };

      #android-gradle-deps = callPackage ./packages/android-gradle-deps.nix { inherit sp; };

      #macos = callPackage ./packages/macos.nix { inherit sp; };
      macos-cocoa-deps = callPackage ./packages/macos-cocoa-deps.nix { inherit sp; };

      #ios = callPackage ./packages/ios.nix { inherit sp; };
      ios-cocoa-deps = callPackage ./packages/linux-nix.nix { inherit sp; };
    };
  };
}
