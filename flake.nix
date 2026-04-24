{
  nixConfig.bash-prompt = "\[selfprivacy\]$ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      #nixpkgs-unstable,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        {
          self',
          inputs',
          pkgs,
          system,
          lib,
          config,
          ...
        }:
        let
          spRunnables = [
            "run-test"
            "run-analyze"
            "run-scanner"

            "build-android-apk"
            "build-android-aab"

            "sign-android-standalone"
            "sign-android-fdroid"
            "sign-android-google"
            # "sign-macos"
            # "sign-ios"

            "deploy-android-google"
            "deploy-android-fdroid"
            # "deploy-macos"
            # "deploy-ios"
          ];

          spJava = pkgs.openjdk17_headless;
          spFlutter = pkgs.flutter335;
          spAndroidSDK = pkgs.androidenv.composeAndroidPackages {
            platformToolsVersion = "36.0.2";
            buildToolsVersions = [
              "36.0.0"
              "35.0.0"
            ];
            platformVersions = [
              "36"
              "35"
              "34"
            ];
            includeNDK = true;
            ndkVersions = [ "27.0.12077973" ];
            cmakeVersions = [ "3.22.1" ];

            # includeEmulator = true;
            # includeSystemImages = true;
            # systemImageTypes = [ "google_apis_playstore" ];
            # abiVersions = [ "x86_64" ];
          };

          buildTools = with pkgs; [
            spFlutter
            spFlutter.dart
            clang
            bash
            curl
            git
            unzip
            which
            xz
            cmake
            ninja
            pkg-config
            libsecret
            cacert
            (if pkgs.stdenv.isDarwin then cocoapods else "")
          ];

          androidBuildTools = [
            spAndroidSDK.androidsdk
            spJava
          ];

          buildLibs =
            with pkgs;
            (
              if pkgs.stdenv.isLinux then
                [
                  gtk3
                  glib
                  pcre
                  util-linux
                  libselinux
                  libsepol
                  libthai
                  libdatrie
                  xorg.libXdmcp
                  xorg.libXtst
                  libxkbcommon
                  dbus
                  at-spi2-core
                  libsecret
                  jsoncpp
                  xorg.libX11
                  libepoxy
                  libgcrypt
                  libgpg-error
                  wayland
                  patchelf
                  wrapGAppsHook3
                  autoPatchelfHook
                  xdg-user-dirs
                  libsecret
                ]
              else
                [ ]
            );

          signTools = with pkgs; [
            apksigner
            fastlane
          ];

          fdroidTools = with pkgs; [
            fdroidserver
          ];

          analyzeTools = [
            spFlutter
            spFlutter.dart
          ];

          scannerTools = with pkgs; [
            sonar-scanner-cli-minimal
          ];

          flatpakTools = with pkgs; [
            flatpak
            flatpak-builder
            ostree
            patchelf
            cacert
            appstream
          ];

          appimageTools = with pkgs; [
            appstream
            squashfsTools
            patchelf
            self'.packages.appimagetool
            self'.packages.appimage-runtime
            which
          ];

          archiveTools = with pkgs; [
            gnutar
            xz
            patchelf
          ];

          testTools = [
            spFlutter
            spFlutter.dart
          ];

          toNixFromYAML =
            path:
            pkgs.lib.importJSON (
              pkgs.runCommand "yml2json" {
                nativeBuildInputs = [ pkgs.yq ];
                src = path;
              } "cat $src | yq . > $out"
            );

          shortSystem = builtins.head (lib.strings.splitString "-" system);

          spApplicationNix = self'.packages.build-linux-nix;
          spApplicationGeneric = self'.packages.build-linux-generic;
          spApplicationMetadata = toNixFromYAML ./pubspec.yaml;

          spFlutterDeps = self'.packages.build-flutter-deps;
          spFlutterPubspec = ./pubspec.yaml;
          spFlutterLockfile = ./pubspec.lock;

          spFlatpakManifestFile = ./flatpak-nix.yml;
          spFlatpakSDK = self'.packages.build-linux-flatpak-sdk;

          spDesktopFile = ./org.selfprivacy.app.desktop;
          spAppstreamFile = ./org.selfprivacy.app.metainfo.xml;
          spIconPNGFile = ./assets/images/icon/logo_android.png;
          spIconSVGFile = ./assets/images/icon/logo.svg;
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };

            overlays = [
              # (final: prev: {
              #   pkgs-unstable = import nixpkgs-unstable {
              #     inherit system;

              #     config = {
              #       allowUnfree = true;
              #       android_sdk.accept_license = true;
              #     };
              #   };
              # })
            ];
          };

          packages = {
            default = spApplicationNix;

            run-test = pkgs.writeShellApplication {
              name = "run-test";
              runtimeInputs = testTools;
              text = "flutter test --coverage";
            };
            run-analyze = pkgs.writeShellApplication {
              name = "run-analyze";
              runtimeInputs = analyzeTools;
              text = "flutter analyze";
            };
            run-scanner = pkgs.writeShellApplication {
              name = "run-scanner";
              runtimeInputs = scannerTools;
              text = "";
            };

            build-linux-nix = spFlutter.buildFlutterApplication rec {
              pname = spApplicationMetadata.name;
              version = spApplicationMetadata.version;

              autoPubspecLock = ./pubspec.lock;

              src = ./.;

              gitHashes = {
                "sp_lints" = "sha256-henUl8JcN6YRSnymnVAiNjm8bmRJGPPjVhLP0EJcZk0=";
              };

              desktopItem = pkgs.makeDesktopItem {
                name = "${pname}";
                exec = "@out@/bin/${pname}";
                desktopName = "SelfPrivacy";
              };

              postInstall = ''
                patchShebangs $out/bin/$pname
                chmod +x $out/bin/$pname
                wrapProgram $out/bin/$pname --set PATH ${pkgs.lib.makeBinPath [ pkgs.xdg-user-dirs ]}

                mkdir -p $out/share/applications
                cp $desktopItem/share/applications/*.desktop $out/share/applications
                substituteInPlace $out/share/applications/*.desktop --subst-var out
              '';
            };

            build-flutter-deps = pkgs.stdenv.mkDerivation {
              pname = "${spApplicationMetadata.name}-linux-deps";
              version = spApplicationMetadata.version;

              nativeBuildInputs = buildTools;

              outputHashMode = "recursive";
              outputHashAlgo = "sha256";
              outputHash = "sha256-QrCYznuWKdwGw2QMLFj78YAp7IyM2zpS5DIbXQVDH60=";

              phases = [ "buildPhase" ];

              buildPhase = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE="$out"

                cp ${spFlutterPubspec} pubspec.yaml
                cp ${spFlutterLockfile} pubspec.lock

                flutter config --no-analytics &>/dev/null
                flutter config --enable-linux-desktop --enable-macos-desktop --enable-windows-desktop --enable-android --enable-ios &>/dev/null
                flutter pub get --no-precompile --enforce-lockfile

                # Delete any non-deterministic miscellaneous files
                find "$out" -name "*.stamp" -delete
                find "$out" -name ".dart_tool" -type d -exec rm -rf {} \; || true
                find "$out" -name ".git" -type d -exec rm -rf {} \; || true
                find "$out" -name ".cache" -type d -exec rm -rf {} \; || true
                find "$out" -name "active_rootfs" -type d -exec rm -rf {} \; || true
                find "$out" -name "*.snapshot" -delete
                find "$out" -name "*.dill" -delete
                find "$out" -name ".flutter-plugins-dependencies" -delete
                find "$out" -exec touch -d '1970-01-01' {} +

                # Here it should be unsafeDiscardReferences.out = true, but it doesn't work
                # It rewrites all references to the Nix store to satisfy the building process
                # It complains mainly because of the sp-lints Git hooks
                grep -rl '/nix/store' "$out" | xargs -r sed -i 's|/nix/store/[a-z0-9]\{32\}-[^/:\"]*|/nix/store/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee-scrubbed|g' || true
              '';
            };

            build-linux-generic = pkgs.stdenv.mkDerivation {
              name = "${spApplicationMetadata.name}-generic";
              version = spApplicationMetadata.version;
              src = ./.;

              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE=$HOME/pubcache

                mkdir $PUB_CACHE
                ln -s ${spFlutterDeps}/* $PUB_CACHE/

                cp -r $src/. .
                chmod -R u+rw .

                flutter config --no-analytics &>/dev/null
                flutter config --enable-linux-desktop &>/dev/null
                flutter pub get --offline --enforce-lockfile
                flutter build linux --release --no-pub
              '';

              installPhase = ''
                mkdir -p $out/bin
                cp -r build/linux/x64/release/bundle/* $out/
                mv $out/selfprivacy $out/org.selfprivacy.app
                ln -sr $out/org.selfprivacy.app $out/bin/org.selfprivacy.app
              '';

              meta = {
                mainProgram = "org.selfprivacy.app";
              };
            };

            build-android-apk = pkgs.stdenv.mkDerivation {
              name = "build-android-apk";
              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;
              phases = [ "installPhase" ];

              installPhase = ''
                mkdir -p $out/bin
                cat > $out/bin/$name <<EOF
                #!/usr/bin/env bash
                set -euo pipefail

                export PATH="${
                  pkgs.lib.makeBinPath (
                    buildTools
                    ++ buildLibs
                    ++ [
                      pkgs.coreutils
                      pkgs.bash
                    ]
                  )
                }"
                export PKG_CONFIG_PATH="${
                  pkgs.lib.makeSearchPathOutput "dev" "lib/pkgconfig" (buildTools ++ buildLibs)
                }"
                export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath (buildTools ++ buildLibs)}"

                export HOME=\$(mktemp -d)
                export PUB_CACHE=\$HOME/pubcache

                mkdir \$PUB_CACHE
                cp -r ${spFlutterDeps}/* \$PUB_CACHE/
                chmod -R u+w \$PUB_CACHE/

                export JAVA_HOME="${spJava.home}"
                export ANDROID_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_SDK_ROOT="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_NDK_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk/ndk"

                flutter config --no-analytics &>/dev/null
                flutter config --enable-android &>/dev/null
                flutter pub get --offline --enforce-lockfile
                flutter build apk --release --no-pub
                EOF
                chmod +x $out/bin/$name
              '';
            };

            build-android-aab = pkgs.stdenv.mkDerivation {
              name = "build-android-aab";
              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;
              phases = [ "installPhase" ];

              installPhase = ''
                mkdir -p $out/bin
                cat > $out/bin/$name <<EOF
                #!/usr/bin/env bash
                set -euo pipefail

                export PATH="${
                  pkgs.lib.makeBinPath (
                    buildTools
                    ++ buildLibs
                    ++ [
                      pkgs.coreutils
                      pkgs.bash
                    ]
                  )
                }"

                export HOME=$(mktemp -d)
                export PUB_CACHE=$HOME/pubcache

                mkdir \$PUB_CACHE
                cp -r ${spFlutterDeps}/* \$PUB_CACHE/
                chmod -R u+w \$PUB_CACHE/

                export JAVA_HOME="${spJava.home}"
                export ANDROID_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_SDK_ROOT="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_NDK_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk/ndk"

                flutter config --no-analytics &>/dev/null
                flutter config --enable-android &>/dev/null
                flutter build appbundle --release
                EOF
                chmod +x $out/bin/$name
              '';
            };

            build-linux-flatpak-sdk =
              let
                commitSDK = "94938f2e7cc692b9c95f64a972e92528598979ff72daf4af8b463c3d8878d7e5";
                commitRuntime = "1937643312594be1a9f3839b7c7c14f9d8fe123653bb03f4df42fa66dd7f917c";
              in
              pkgs.stdenv.mkDerivation rec {
                pname = "${spApplicationMetadata.name}-flatpak-sdk";
                version = "25.08";

                nativeBuildInputs = flatpakTools;

                outputHashMode = "recursive";
                outputHashAlgo = "sha256";
                outputHash = "sha256-E+eba/cTugIi0iR1eC+AovpBZagTf1pcAoDX3p+XesU=";

                builder = pkgs.writeShellScript "fetch-flatpak-sdk" ''
                  export HOME=$TMPDIR
                  export FLATPAK_USER_DIR=$HOME/flatpak

                  mkdir -p $out/repo
                  ostree init --repo=$out/ --mode=archive
                  ostree remote --repo=$out/ add --set=gpg-verify=false flathub https://dl.flathub.org/repo/
                  ostree pull --repo=$out/ --mirror --depth=0 flathub runtime/org.freedesktop.Sdk/${shortSystem}/${version}@${commitSDK}
                  ostree pull --repo=$out/ --mirror --depth=0 flathub runtime/org.freedesktop.Platform/${shortSystem}/${version}@${commitRuntime}
                '';
              };

            build-linux-flatpak =
              let
                libsecretGit = pkgs.fetchFromGitLab {
                  domain = "gitlab.gnome.org";
                  owner = "GNOME";
                  repo = "libsecret";
                  rev = "0.21.7";
                  hash = "sha256-uN5+P2VkpoLqYVoruVj0/RM8rMNZSFu0VjKWW30bJrE=";
                };

                libjsoncppGit = pkgs.fetchFromGitHub {
                  owner = "open-source-parsers";
                  repo = "jsoncpp";
                  rev = "1.9.7";
                  hash = "sha256-rf8d2UNTVEZhuiyChK2XnUbfGDvsfXnKADhaSp8qBwQ=";
                };
              in
              pkgs.stdenv.mkDerivation {
                pname = "${spApplicationMetadata.name}-flatpak";
                version = spFlatpakSDK.version;

                nativeBuildInputs = flatpakTools;

                phases = [
                  "buildPhase"
                  "installPhase"
                ];

                buildPhase = ''
                  export HOME=$TMPDIR
                  export FLATPAK_USER_DIR=$HOME/.local/share/flatpak
                  export FLATPAK_SYSTEM_DIR=$HOME/.local/share/flatpak
                  export XDG_DATA_HOME=$HOME/.local/share
                  mkdir -p $FLATPAK_USER_DIR

                  mkdir vendor

                  cp -pr ${spApplicationGeneric}/* vendor/
                  cp -pr ${libjsoncppGit} libjsoncpp
                  cp -pr ${libsecretGit} libsecret
                  cp ${spFlatpakManifestFile} flatpak-nix.yml
                  cp ${spDesktopFile} vendor/org.selfprivacy.app.desktop
                  cp ${spAppstreamFile} vendor/org.selfprivacy.app.metainfo.xml
                  cp ${spIconPNGFile} vendor/org.selfprivacy.app.png
                  #cp ${spIconSVGFile} vendor/org.selfprivacy.app.svg

                  chmod -R +rw vendor/ libsecret/ libjsoncpp/

                  patchelf --set-rpath '/app/lib:$ORIGIN/lib:$ORIGIN/../lib:/usr/lib/x86_64-linux-gnu' vendor/org.selfprivacy.app
                  patchelf --set-interpreter '/lib64/ld-linux-x86-64.so.2' vendor/org.selfprivacy.app
                  for plib in "libdynamic_color_plugin.so" "libflutter_linux_gtk.so" "libflutter_secure_storage_linux_plugin.so" "liburl_launcher_linux_plugin.so"; do
                    patchelf --set-rpath '/app/lib:$ORIGIN:/usr/lib/x86_64-linux-gnu' vendor/lib/"$plib"
                  done
                '';

                installPhase = ''
                  mkdir -p $out

                  mkdir -p $HOME/repo/{repo,objects,refs,extensions,state,tmp}
                  ln -s ${spFlatpakSDK}/config $HOME/repo/
                  ln -s ${spFlatpakSDK}/objects/* $HOME/repo/objects/
                  ln -s ${spFlatpakSDK}/refs/* $HOME/repo/refs/
                  ostree --repo=$HOME/repo/ summary -u

                  flatpak remote-add --user --if-not-exists --no-gpg-verify flathub $HOME/repo
                  flatpak install --user -y flathub org.freedesktop.Sdk/${shortSystem}/${spFlatpakSDK.version} org.freedesktop.Platform/${shortSystem}/${spFlatpakSDK.version}
                  flatpak-builder --user --force-clean --disable-cache --disable-rofiles-fuse --repo=flatpak-repo flatpak-build flatpak-nix.yml
                  flatpak build-bundle flatpak-repo $out/${spApplicationMetadata.name}-${spApplicationMetadata.version}.flatpak org.selfprivacy.app
                '';
              };

            appimagetool = pkgs.appimageTools.wrapType2 {
              pname = "appimagetool";
              version = "1.9.1";

              src = pkgs.fetchurl {
                url = "https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage";
                hash = "sha256-7UzoTw2cr/ZvULzKb/bzWq5UzoE1QIs/ozq/w8s4TrA=";
              };
            };

            appimage-runtime = pkgs.stdenv.mkDerivation rec {
              pname = "appimage-runtime";
              version = "20251108";

              src = pkgs.fetchurl {
                url = "https://github.com/AppImage/type2-runtime/releases/download/continuous/runtime-x86_64";
                hash = "sha256-okGdzkdWg5WuecAf+ppaNB3TOVgTUv8QTQc1J1Qxd+U=";
              };

              phases = [
                "installPhase"
                "patchPhase"
              ];

              installPhase = ''
                mkdir -p $out/bin
                cp $src $out/bin/${pname}
                chmod +x $out/bin/${pname}
              '';
            };

            build-linux-appimage = pkgs.stdenv.mkDerivation {
              name = "${spApplicationMetadata.name}-appimage";
              version = spApplicationMetadata.version;

              nativeBuildInputs = (appimageTools);

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                mkdir -p AppDir
                cp -pr ${spApplicationGeneric}/* AppDir/
                cp ${spDesktopFile} AppDir/org.selfprivacy.app.desktop
                cp ${spAppstreamFile} AppDir/org.selfprivacy.app.metainfo.xml
                cp ${spIconSVGFile} AppDir/org.selfprivacy.app.svg
                chmod -R u+rw AppDir/

                ln -sr AppDir/org.selfprivacy.app AppDir/AppRun

                patchelf --set-rpath '$ORIGIN/lib:$ORIGIN/../lib:/usr/lib/x86_64-linux-gnu' AppDir/org.selfprivacy.app
                patchelf --set-interpreter '/lib64/ld-linux-x86-64.so.2' AppDir/org.selfprivacy.app
                for plib in "libdynamic_color_plugin.so" "libflutter_linux_gtk.so" "libflutter_secure_storage_linux_plugin.so" "liburl_launcher_linux_plugin.so"; do
                  patchelf --set-rpath '$ORIGIN:/usr/lib/x86_64-linux-gnu' AppDir/lib/"$plib"
                done
              '';

              installPhase = ''
                mkdir -p $out

                appimagetool --runtime-file $(which appimage-runtime) AppDir "${spApplicationMetadata.name}-${spApplicationMetadata.version}.AppImage"

                cp "${spApplicationMetadata.name}-${spApplicationMetadata.version}.AppImage" $out/
              '';
            };

            build-linux-archive = pkgs.stdenv.mkDerivation {
              name = "${spApplicationMetadata.name}-archive";
              version = spApplicationMetadata.version;

              nativeBuildInputs = archiveTools;

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                mkdir -p vendor/usr/share/{applications,metainfo,icons} vendor/usr/share/icons/hicolor/{scalable,512x512}/apps/
                cp -pr ${spApplicationGeneric}/* vendor/
                cp ${spDesktopFile} vendor/usr/share/applications/org.selfprivacy.app.desktop
                cp ${spAppstreamFile} vendor/usr/share/metainfo/org.selfprivacy.app.metainfo.xml
                cp ${spIconPNGFile} vendor/usr/share/icons/hicolor/512x512/apps/org.selfprivacy.app.png
                cp ${spIconSVGFile} vendor/usr/share/icons/hicolor/scalable/apps/org.selfprivacy.app.svg
                chmod -R +rw vendor/

                patchelf --set-rpath '$ORIGIN/lib:$ORIGIN/../lib:/usr/lib/x86_64-linux-gnu' vendor/org.selfprivacy.app
                patchelf --set-interpreter '/lib64/ld-linux-x86-64.so.2' vendor/org.selfprivacy.app
                for plib in "libdynamic_color_plugin.so" "libflutter_linux_gtk.so" "libflutter_secure_storage_linux_plugin.so" "liburl_launcher_linux_plugin.so"; do
                  patchelf --set-rpath '$ORIGIN:/usr/lib/x86_64-linux-gnu' vendor/lib/"$plib"
                done
              '';

              installPhase = ''
                mkdir -p $out

                tar -cvf "${spApplicationMetadata.name}-${spApplicationMetadata.version}.tar.xz" -C vendor/ .
                cp "${spApplicationMetadata.name}-${spApplicationMetadata.version}.tar.xz" $out/
              '';
            };

            sign-android-standalone = pkgs.writeShellApplication {
              name = "sign-android-standalone-apk";
              runtimeInputs = [ ];
              text = "";
            };
            sign-android-fdroid = pkgs.writeShellApplication {
              name = "sign-android-fdroid-apk";
              runtimeInputs = [ ];
              text = "";
            };
            sign-android-google = pkgs.writeShellApplication {
              name = "sign-android-google-aab";
              runtimeInputs = [ ];
              text = "";
            };
            # sign-macos = null;
            # sign-ios = null;

            deploy-android-google = pkgs.writeShellApplication {
              name = "deploy-android-fdroid-apk";
              runtimeInputs = [ ];
              text = "";
            };

            deploy-android-fdroid = pkgs.writeShellApplication {
              name = "deploy-android-fdroid-apk";
              runtimeInputs = [ ];
              text = "";
            };
            # deploy-macos = null;
            # deploy-ios = null;
          };

          apps = lib.genAttrs spRunnables (name: {
            type = "app";
            program = "${self'.packages.${name}}/bin/${name}";
          });

          devShells = {
            shell-analyze = pkgs.mkShell { nativeBuildInputs = analyzeTools; };
            shell-scanner = pkgs.mkShell { nativeBuildInputs = scannerTools; };
            shell-test = pkgs.mkShell { nativeBuildInputs = testTools; };
            shell-sign = pkgs.mkShell { nativeBuildInputs = signTools; };
            shell-build-android = pkgs.mkShell {
              nativeBuildInputs = buildTools ++ androidBuildTools ++ [ self'.packages.build-android-apk self'.packages.build-android-aab ];
              buildInputs = buildLibs;

              JAVA_HOME = "${spJava.home}";
              ANDROID_HOME = "${spAndroidSDK.androidsdk}/libexec/android-sdk";
              ANDROID_SDK_ROOT = "${spAndroidSDK.androidsdk}/libexec/android-sdk";
              ANDROID_NDK_HOME = "${spAndroidSDK.androidsdk}/libexec/android-sdk/ndk";

              shellHook = ''
                export TMP=$(mktemp -d)
                export HOME="$TMP"
                export PUB_CACHE=''${PUB_CACHE:-"$HOME/.pub-cache"}
              '';
            };
            shell-build-linux = pkgs.mkShell {
              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;

              shellHook = ''
                export TMP=$(mktemp -d)
                export HOME="$TMP"
                export PUB_CACHE=''${PUB_CACHE:-"$HOME/.pub-cache"}
              '';
            };

            shell-build-linux-flatpak = pkgs.mkShell {
              nativeBuildInputs = flatpakTools;

              shellHook = ''
                export TMP=$(mktemp -d)
                export HOME="$TMP"
              '';
            };

            shell-build-linux-appimage = pkgs.mkShell {
              nativeBuildInputs = appimageTools;

              shellHook = ''
                export TMP=$(mktemp -d)
                export HOME="$TMP"
              '';
            };

            #shell-build-ios = pkgs.mkShell { nativeBuildinputs = iosTools; buildInputs = iosLibs };
            shell-build-macos = pkgs.mkShell {
              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;
            };
            shell-fdroid = pkgs.mkShell { nativeBuildInputs = fdroidTools; };
          };
        };
    };
}
