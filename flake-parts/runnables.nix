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
          # --machine emits JSON to stdout for sonar-flutter's Flutter unit
          # tests sensor; --coverage writes coverage/lcov.info.
          text = ''
            flutter test --machine --coverage > tests.output
          '';
        };

        analyze-flutter = pkgs.writeShellApplication {
          name = "analyze-flutter";
          runtimeInputs = sp.analyzeTools;
          text = "flutter analyze --no-fatal-infos";
        };

        pubspec-deps-json = pkgs.writeShellApplication {
          name = "pubspec-deps-json";
          runtimeInputs = [ pkgs.yq ];
          text = ''
            lockfile="''${1:-pubspec.lock}"
            yq '
              .packages | to_entries | map({
                name: .key,
                version: .value.version,
                source: .value.source,
                isDirect: ((.value.dependency // "transitive") | startswith("direct")),
                homepage: (
                  if .value.source == "hosted" and .value.description.url == "https://pub.dev"
                  then "https://pub.dev/packages/" + .key
                  else null
                  end
                ),
                changelog: (
                  if .value.source == "hosted" and .value.description.url == "https://pub.dev"
                  then "https://pub.dev/packages/" + .key + "/changelog"
                  else null
                  end
                )
              }) | { dependencies: . }
            ' < "$lockfile"
          '';
        };

        scan-sonarqube = pkgs.writeShellApplication {
          name = "scan-sonarqube";
          runtimeInputs = sp.scannerTools;
          text = ''
            : "''${SONAR_TOKEN:?SONAR_TOKEN env var required}"

            EXCLUSIONS="lib/**/*.g.dart,lib/**/*.graphql.dart,lib/**/router.gr.dart,lib/**/hive_registrar.g.dart"

            SONAR_PARAMS="-Dsonar.projectKey=SelfPrivacy-Flutter-App"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.sources=lib"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.tests=test"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.host.url=https://analyzer.selfprivacy.org"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.token=$SONAR_TOKEN"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.dart.lcov.reportPaths=coverage/lcov.info"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.exclusions=$EXCLUSIONS"
            SONAR_PARAMS="$SONAR_PARAMS -Dsonar.coverage.exclusions=$EXCLUSIONS"

            if [ -n "''${SONAR_PULLREQUEST_KEY:-}" ]; then
              SONAR_PARAMS="$SONAR_PARAMS -Dsonar.pullrequest.key=$SONAR_PULLREQUEST_KEY"
              SONAR_PARAMS="$SONAR_PARAMS -Dsonar.pullrequest.branch=$SONAR_PULLREQUEST_BRANCH"
              SONAR_PARAMS="$SONAR_PARAMS -Dsonar.pullrequest.base=$SONAR_PULLREQUEST_BASE"
            elif [ -n "''${SONAR_BRANCH_NAME:-}" ]; then
              SONAR_PARAMS="$SONAR_PARAMS -Dsonar.branch.name=$SONAR_BRANCH_NAME"
            fi

            # shellcheck disable=SC2086
            sonar-scanner $SONAR_PARAMS 2>&1 \
              | grep --line-buffered -v 'File not included in SonarQube' \
              || true
            exit "''${PIPESTATUS[0]}"
          '';
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

        deploy-android-google = pkgs.writeShellApplication {
          name = "deploy-android-google";
          runtimeInputs = sp.deployTools;
          text = ''
            : "''${PLAY_JSON_KEY_FILE:?PLAY_JSON_KEY_FILE env var required}"
            : "''${AAB_PATH:?AAB_PATH env var required}"

            PLAY_JSON_KEY_FILE="$(realpath "$PLAY_JSON_KEY_FILE")"
            AAB_PATH="$(realpath "$AAB_PATH")"
            export PLAY_JSON_KEY_FILE AAB_PATH

            export FASTLANE_SKIP_UPDATE_CHECK=1
            export FASTLANE_OPT_OUT_USAGE=1

            fastlane android upload_internal
          '';
        };
      };
    };
}
