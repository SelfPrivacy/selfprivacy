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

        record-vcr = pkgs.writeShellApplication {
          name = "record-vcr";
          runtimeInputs = sp.testTools;
          text = ''
            load_vcr_credential() {
              local name="$1"
              local value

              if [ -n "''${!name:-}" ]; then
                return
              fi

              if [ -t 0 ]; then
                read -r -s -p "$name: " value
                printf '\n' >&2
                if [ -n "$value" ]; then
                  export "$name=$value"
                fi
              fi
            }

            for name in \
              HETZNER_API_TOKEN \
              DIGITAL_OCEAN_API_TOKEN \
              CLOUDFLARE_API_TOKEN \
              DESEC_API_TOKEN \
              PORKBUN_API_KEY \
              PORKBUN_SECRET_API_KEY \
              BACKBLAZE_APPLICATION_KEY_ID \
              BACKBLAZE_APPLICATION_KEY
            do
              load_vcr_credential "$name"
            done

            export VCR_MODE=record
            flutter test "$@"
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
        # deploy-macos = null;

        sign-ios = pkgs.writeShellApplication {
          name = "sign-ios";
          runtimeInputs = sp.deployTools;
          text = ''
            : "''${MATCH_PASSWORD:?MATCH_PASSWORD env var required}"

            # Auth goes separately via MATCH_GIT_BASIC_AUTHORIZATION
            # (base64 of user:token) so no secret ends up in the logged URL
            MATCH_GIT_URL="''${MATCH_GIT_URL:-https://git.selfprivacy.org/SelfPrivacy/fastlane-match.git}"
            export MATCH_GIT_URL

            # fastlane resolves relative paths against fastlane/, not the repo root
            XCARCHIVE_PATH="$(realpath "''${XCARCHIVE_PATH:-Runner.xcarchive}")"
            IPA_OUTPUT_DIR="$PWD"
            export XCARCHIVE_PATH IPA_OUTPUT_DIR

            DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
            export DEVELOPER_DIR
            # security(1), codesign(1), and the xcodebuild/xcrun shims live in /usr/bin
            export PATH="$PATH:/usr/bin"

            export FASTLANE_SKIP_UPDATE_CHECK=1
            export FASTLANE_OPT_OUT_USAGE=1

            fastlane ios sign_release
          '';
        };

        deploy-ios = pkgs.writeShellApplication {
          name = "deploy-ios";
          runtimeInputs = sp.deployTools;
          text = ''
            : "''${ASC_KEY_ID:?ASC_KEY_ID env var required}"
            : "''${ASC_ISSUER_ID:?ASC_ISSUER_ID env var required}"
            : "''${ASC_KEY_P8_FILE:?ASC_KEY_P8_FILE env var required}"

            ASC_KEY_P8_FILE="$(realpath "$ASC_KEY_P8_FILE")"
            IPA_PATH="$(realpath "''${IPA_PATH:-selfprivacy-ios-signed.ipa}")"
            export ASC_KEY_P8_FILE IPA_PATH

            DEVELOPER_DIR="${sp.ourXcode}/Contents/Developer"
            export DEVELOPER_DIR
            # fastlane's Transporter lookup goes through xcrun in /usr/bin
            export PATH="$PATH:/usr/bin"

            export FASTLANE_SKIP_UPDATE_CHECK=1
            export FASTLANE_OPT_OUT_USAGE=1

            fastlane ios upload_testflight
          '';
        };

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
