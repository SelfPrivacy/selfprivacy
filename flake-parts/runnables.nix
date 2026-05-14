{ ... }:

{
  perSystem =
    {
      self',
      pkgs,
      lib,
      sp,
      ...
    }:
    {

      # Converts a list of runnable names into Nix applications to `nix run`
      apps = lib.genAttrs sp.runnables (name: {
        type = "app";
        program = "${self'.packages.${name}}/bin/${name}";
      });

      packages = with pkgs; {
        # Generic runnables
        test-flutter = pkgs.writeShellApplication {
          name = "test-flutter";
          runtimeInputs = sp.testTools;
          text = "flutter test --coverage";
        };

        analyze-flutter = pkgs.writeShellApplication {
          name = "analyze-flutter";
          runtimeInputs = sp.analyzeTools;
          text = "flutter analyze";
        };

        scan-sonarcube = pkgs.writeShellApplication {
          name = "scan-sonarcube";
          runtimeInputs = sp.scannerTools;
          text = "";
        };

        build-macos = callPackage ./runnables/build-macos.nix { inherit sp; };

        build-ios = callPackage ./runnables/build-ios.nix { inherit sp; };

        # sign-macos = null;
        # sign-ios = null;
        # deploy-macos = null;
        # deploy-ios = null;

        build-android = callPackage ./runnables/build-android.nix { inherit sp; };

        # FIXME: DRY these using cortesian products

        # sign-android-standalone = pkgs.writeShellApplication {
        #   name = "sign-android-standalone-apk";
        #   runtimeInputs = [ ];
        #   text = "";
        # };

        # sign-android-fdroid = pkgs.writeShellApplication {
        #   name = "sign-android-fdroid-apk";
        #   runtimeInputs = [ ];
        #   text = "";
        # };

        # sign-android-google = pkgs.writeShellApplication {
        #   name = "sign-android-google-aab";
        #   runtimeInputs = [ ];
        #   text = "";
        # };

        # deploy-android-google = pkgs.writeShellApplication {
        #   name = "deploy-android-fdroid-apk";
        #   runtimeInputs = [ ];
        #   text = "";
        # };

        # deploy-android-fdroid = pkgs.writeShellApplication {
        #   name = "deploy-android-fdroid-apk";
        #   runtimeInputs = [ ];
        #   text = "";
        # };
      };
    };
}
