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

            apksigner sign --ks "$CI_KEYSTORE_FILE" --ks-key-alias standalone --ks-pass pass:"$CI_KEYSTORE_PASS" --key-pass pass:"$CI_KEYSTORE_PASS" --min-sdk-version 24 --out selfprivacy-standalone-signed.apk "$1"
            apksigner verify --print-certs selfprivacy-standalone-signed.apk
          '';
        };

        sign-android-fdroid = pkgs.writeShellApplication {
          name = "sign-android-fdroid-apk";
          runtimeInputs = sp.signTools;
          text = ''
            JAVA_HOME="${sp.ourJava.home}"
            export JAVA_HOME

            # Alias d3e165d4 is fdroidserver's per-app key for the F-Droid
            # release flavor, derived deterministically from the keystore
            # password + applicationId. Existing installs are signed with
            # this cert (SHA-256 6837:6b9f:712b:cbbf:...); switching it
            # breaks Android's upgrade check.
            apksigner sign --ks "$CI_KEYSTORE_FILE" --ks-key-alias d3e165d4 --ks-pass pass:"$CI_KEYSTORE_PASS" --key-pass pass:"$CI_KEYSTORE_PASS" --min-sdk-version 24 --out selfprivacy-fdroid-signed.apk "$1"
            apksigner verify --print-certs selfprivacy-fdroid-signed.apk
          '';
        };

        sign-android-nightly = pkgs.writeShellApplication {
          name = "sign-android-nightly-apk";
          runtimeInputs = sp.signTools;
          text = ''
            JAVA_HOME="${sp.ourJava.home}"
            export JAVA_HOME

            # Alias 72994518 is fdroidserver's per-app key for
            # org.selfprivacy.app.nightly, derived deterministically from
            # the keystore password + applicationId. Existing installs are
            # signed with this cert (SHA-256 8119:1731:ecd9:eaae:...);
            # switching it breaks Android's upgrade check.
            apksigner sign --ks "$CI_KEYSTORE_FILE" --ks-key-alias 72994518 --ks-pass pass:"$CI_KEYSTORE_PASS" --key-pass pass:"$CI_KEYSTORE_PASS" --min-sdk-version 24 --out selfprivacy-nightly-signed.apk "$1"
            apksigner verify --print-certs selfprivacy-nightly-signed.apk
          '';
        };

        sign-android-google = pkgs.writeShellApplication {
          name = "sign-android-google-aab";
          runtimeInputs = sp.signTools;
          text = ''
            JAVA_HOME="${sp.ourJava.home}"
            REAL_ALIAS=$(keytool -list -keystore "$CI_KEYSTORE_FILE" -storepass "$CI_KEYSTORE_PASS" | grep "PrivateKeyEntry" | awk -F',' '{print $1}' | xargs)
            export JAVA_HOME REAL_ALIAS
            jarsigner -sigalg SHA256withRSA -digestalg SHA-256 -keystore "$CI_KEYSTORE_FILE" -storepass:env CI_KEYSTORE_PASS -signedjar selfprivacy-google-signed.aab "$1" "$REAL_ALIAS"
            jarsigner -verify -verbose selfprivacy-google-signed.aab
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
