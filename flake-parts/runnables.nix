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

        scan-sonarqube = pkgs.writeShellApplication {
          name = "scan-sonarqube";
          runtimeInputs = sp.scannerTools;
          text = "";
        };

        build-ios = callPackage ./runnables/build-ios.nix { inherit sp; };

        # sign-macos = null;
        # sign-ios = null;
        # deploy-macos = null;
        # deploy-ios = null;

        # FIXME: DRY these using cortesian products

        sign-android-standalone = pkgs.writeShellApplication {
          name = "sign-android-standalone-apk";
          runtimeInputs = sp.signTools;
          text = ''
            JAVA_HOME="${sp.ourJava.home}"
            export JAVA_HOME

            apksigner sign --ks "$CI_KEYSTORE_FILE" --ks-pass pass:"$CI_KEYSTORE_PASS" --key-pass pass:"$CI_KEYSTORE_PASS" --min-sdk-version 24 --out selfprivacy-standalone-signed.apk "$1"
          '';
        };

        sign-android-fdroid = pkgs.writeShellApplication {
          name = "sign-android-fdroid-apk";
          runtimeInputs = sp.signTools;
          text = ''
            JAVA_HOME="${sp.ourJava.home}"
            export JAVA_HOME

            apksigner sign --ks "$CI_KEYSTORE_FILE" --ks-pass pass:"$CI_KEYSTORE_PASS" --key-pass pass:"$CI_KEYSTORE_PASS" --min-sdk-version 24 --out selfprivacy-fdroid-signed.apk "$1"
          '';
        };

        sign-android-google = pkgs.writeShellApplication {
          name = "sign-android-google-aab";
          runtimeInputs = sp.signTools;
          text = ''
            JAVA_HOME="${sp.ourJava.home}"
            export JAVA_HOME

            apksigner sign --ks "$CI_KEYSTORE_FILE" --ks-pass pass:"$CI_KEYSTORE_PASS" --key-pass pass:"$CI_KEYSTORE_PASS" --min-sdk-version 24 --out selfprivacy-google-signed.aab "$1"
          '';
        };

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
