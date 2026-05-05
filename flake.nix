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
          # What actually is needed to be passed during the build
          spProjectFiles = lib.fileset.toSource {
            root = ./.;
            fileset = lib.fileset.unions [
              ./android
              ./assets
              ./ios
              ./lib
              ./linux
              ./macos
              ./pubspec.lock
              ./pubspec.yaml
              ./test
            ];
          };

          # Project named files and metadata
          spApplicationNix = self'.packages.linux-nix;
          spApplicationGeneric = self'.packages.linux-generic;
          spApplicationMetadata = toNixFromYAML ./pubspec.yaml;

          spFlutterDeps = self'.packages.flutter-deps;
          spFlutterPubspec = ./pubspec.yaml;
          spFlutterLockfile = ./pubspec.lock;

          spCocoaMacosDeps = self'.packages.macos-cocoa-deps;
          spCocoaIosDeps = self'.packages.ios-cocoa-deps;
          spCocoaMacosLipoPatch = ./ci/darwin/project.pbxproj.macos.patch;
          spCocoaIosLipoPatch = ./ci/darwin/project.pbxproj.ios.patch;
          spCocoaLipoScript = ./ci/darwin/lipo;

          spFlatpakManifestFile = ./ci/flatpak/flatpak-nix.yml;
          spFlatpakSDK = self'.packages.linux-flatpak-sdk;

          spDesktopFile = ./org.selfprivacy.app.desktop;
          spAppstreamFile = ./org.selfprivacy.app.metainfo.xml;
          spIconPNGFile = ./assets/images/icon/logo_android.png;
          spIconSVGFile = ./assets/images/icon/logo.svg;

          # `nix run` applications
          spRunnables = [
            "test-flutter"
            "analyze-flutter"
            "scan-sonarcube"

            "build-android"
            "build-macos"
            "build-ios"

            # "sign-android"
            # "sign-macos"
            # "sign-ios"

            # "deploy-android"
            # "deploy-macos"
            # "deploy-ios"
          ];

          # Named dependencies
          spJava = pkgs.openjdk17_headless;
          spXcode = pkgs.darwin.xcode_26_1_Apple_silicon;
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

          # Dependency groups
          buildTools =
            with pkgs;
            [
              spFlutter
              spFlutter.dart
              util-linux
              findutils
              gnugrep
              coreutils
              curl
              bash
              git
              cacert
              unzip
              which
              xz
              lndir
            ]
            ++ lib.optionals stdenv.isLinux [

              clang
              cmake
              ninja
              pkg-config
              libsecret
            ]
            ++ lib.optionals stdenv.isDarwin [
              ruby
              cocoapods
              rsync
              darwin.DarwinTools
              darwin.sigtool
              xcbuild
            ];

          androidBuildTools = [
            spAndroidSDK.androidsdk
            spJava
          ];

          buildLibs =
            with pkgs;
            [ ]
            ++
              lib.optionals stdenv.isLinux

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
            ++ lib.optionals stdenv.isDarwin [ ];

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

          # Handy functions, variables, and utilities
          toNixFromYAML =
            path:
            pkgs.lib.importJSON (
              pkgs.runCommand "yml2json" {
                nativeBuildInputs = [ pkgs.yq ];
                src = path;
              } "cat $src | yq . > $out"
            );

          shortSystem = builtins.head (lib.strings.splitString "-" system);
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

            # Generic runnables
            test-flutter = pkgs.writeShellApplication {
              name = "test-flutter";
              runtimeInputs = testTools;
              text = "flutter test --coverage";
            };

            analyze-flutter = pkgs.writeShellApplication {
              name = "analyze-flutter";
              runtimeInputs = analyzeTools;
              text = "flutter analyze";
            };

            scan-sonarcube = pkgs.writeShellApplication {
              name = "scan-sonarcube";
              runtimeInputs = scannerTools;
              text = "";
            };

            # Generic packages with dependencies for all platforms
            flutter-deps = pkgs.stdenv.mkDerivation {
              pname = "${spApplicationMetadata.name}-flutter-deps";
              version = spApplicationMetadata.version;
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./pubspec.yaml
                  ./pubspec.lock
                ];
              };

              nativeBuildInputs = buildTools;

              outputHashMode = "recursive";
              outputHashAlgo = "sha256";
              outputHash = "sha256-flOH0vo8i6C6tH/iqAx8CGnp1iOLAj4cDH28isFM/dA=";

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE="$HOME/pubcache"
                export XDG_CONFIG_HOME="$HOME/.config"

                export FLUTTER_NO_ANALYTICS=1
                export CI=true

                cp "$src/pubspec.yaml" pubspec.yaml
                cp "$src/pubspec.lock" pubspec.lock

                flutter config --no-analytics &>/dev/null
                flutter config --enable-linux-desktop --enable-macos-desktop --enable-windows-desktop --enable-android --enable-ios &>/dev/null
                flutter pub get --no-precompile --enforce-lockfile

                # Delete any non-deterministic miscellaneous files
                find "$PUB_CACHE" -type f \( -name "*.stamp" -o \
                                             -name "*.snapshot" -o \
                                             -name "*.dill" -o \
                                             -name ".flutter-plugins-dependencies" \) -exec rm -f {} + || true

                find "$PUB_CACHE" -type d \( -name ".dart_tool" -o \
                                             -name ".dart-tool" -o \
                                             -name ".git" -o \
                                             -name ".cache" -o \
                                             -name "active_roots" \) -exec rm -rf {} + || true

                # Here it should be unsafeDiscardReferences.out = true, but it doesn't work
                # It rewrites all references to the Nix store to satisfy the building process
                # It complains mainly because of the sp-lints Git hooks
                grep -rl '/nix/store' "$PUB_CACHE" | xargs -r sed -i 's|/nix/store/[a-z0-9]\{32\}-[^/:\"]*|/nix/store/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee-scrubbed|g' || true
              '';

              installPhase = ''
                mv $PUB_CACHE $out
              '';
            };

            # Linux packages
            linux-nix = spFlutter.buildFlutterApplication {
              pname = spApplicationMetadata.name;
              version = spApplicationMetadata.version;
              src = spProjectFiles;

              meta = {
                platforms = [
                  "x86_64-linux"
                  "aarch64-linux"
                ];
              };

              autoPubspecLock = ./pubspec.lock;

              gitHashes = {
                "sp_lints" = "sha256-henUl8JcN6YRSnymnVAiNjm8bmRJGPPjVhLP0EJcZk0=";
              };

              desktopItem = pkgs.makeDesktopItem {
                name = "${spApplicationMetadata.name}";
                exec = "@out@/bin/${spApplicationMetadata.name}";
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

            linux-generic = pkgs.stdenv.mkDerivation {
              name = "${spApplicationMetadata.name}-generic";
              version = spApplicationMetadata.version;
              src = spProjectFiles;

              meta = {
                platforms = [
                  "x86_64-linux"
                  "aarch64-linux"
                ];
              };

              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                export HOME=$(mktemp -d)
                export XDG_CONFIG_HOME="$HOME/.config"
                export PUB_CACHE=$HOME/pubcache

                export FLUTTER_NO_ANALYTICS=1
                export CI=true

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

            linux-flatpak-sdk =
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

            linux-flatpak =
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

                  cp -r ${spApplicationGeneric}/* vendor/
                  cp -r ${libjsoncppGit} libjsoncpp
                  cp -r ${libsecretGit} libsecret
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

            linux-appimage = pkgs.stdenv.mkDerivation {
              name = "${spApplicationMetadata.name}-appimage";
              version = spApplicationMetadata.version;

              nativeBuildInputs = (appimageTools);

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                mkdir -p AppDir
                cp -r ${spApplicationGeneric}/* AppDir/
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

            linux-archive = pkgs.stdenv.mkDerivation {
              name = "${spApplicationMetadata.name}-archive";
              version = spApplicationMetadata.version;

              nativeBuildInputs = archiveTools;

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                mkdir -p vendor/usr/share/{applications,metainfo,icons} vendor/usr/share/icons/hicolor/{scalable,512x512}/apps/
                cp -r ${spApplicationGeneric}/* vendor/
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

            # Darwin packages and runnables
            macos-cocoa-deps = pkgs.stdenv.mkDerivation {
              pname = "${spApplicationMetadata.name}-macos-cocoa-deps";
              version = spApplicationMetadata.version;
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./pubspec.yaml
                  ./pubspec.lock
                  ./macos
                ];
              };

              nativeBuildInputs = buildTools;

              outputHashMode = "recursive";
              outputHashAlgo = "sha256";
              outputHash = "sha256-ueNGV7XYUEHtOipkJ7SzdXQ2JqSCOX1xpZ84ycp+LpE=";

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                export HOME=$(mktemp -d)
                export XDG_CONFIG_HOME="$HOME/.config"
                export PUB_CACHE="$HOME/pubcache"
                export GEM_HOME="$HOME/gemcache"
                export LANG="en_US.UTF-8"

                export FLUTTER_NO_ANALYTICS=1
                export CI=true

                mkdir $PUB_CACHE
                lndir -silent ${spFlutterDeps} $PUB_CACHE

                pushd $HOME
                cp -r $src/macos .
                cp $src/pubspec.yaml .
                cp $src/pubspec.lock .
                chmod -R u+w macos

                flutter config --no-analytics &>/dev/null
                flutter config --enable-macos-desktop --enable-ios &>/dev/null
                flutter pub get --no-precompile --enforce-lockfile

                mkdir macos/scripts
                cp ${spCocoaLipoScript} macos/scripts/lipo
                patch -p1 < ${spCocoaMacosLipoPatch}
                popd

                mkdir $GEM_HOME
                pushd $HOME/macos
                pod install
                rm Pods/Pods.xcodeproj/project.pbxproj
                find . -type d \( -name .symlinks -o \
                                  -name xcuserdata \) -exec rm -rf {} + || true
                find Flutter/ephemeral/ -type f -mindepth 1 -exec rm -f {} + || true
                popd
              '';

              installPhase = ''
                mkdir -p $out

                mv $HOME/macos $out/
                mv $HOME/.cocoapods $out/cocoapods
              '';
            };

            ios-cocoa-deps = pkgs.stdenv.mkDerivation {
              pname = "${spApplicationMetadata.name}-ios-cocoa-deps";
              version = spApplicationMetadata.version;
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./pubspec.yaml
                  ./pubspec.lock
                  ./ios
                ];
              };

              nativeBuildInputs = buildTools;

              outputHashMode = "recursive";
              outputHashAlgo = "sha256";
              outputHash = "sha256-iRsTECtxnLH0haMwydYR4h67bPzgKcVtR7Hi8qasT3I=";

              phases = [
                "buildPhase"
                "installPhase"
              ];

              buildPhase = ''
                export HOME=$(mktemp -d)
                export XDG_CONFIG_HOME="$HOME/.config"
                export PUB_CACHE="$HOME/pubcache"
                export GEM_HOME="$HOME/gemcache"
                export LANG="en_US.UTF-8"

                export FLUTTER_NO_ANALYTICS=1
                export CI=true

                mkdir $PUB_CACHE
                lndir -silent ${spFlutterDeps} $PUB_CACHE

                pushd $HOME
                cp -r $src/ios .
                cp $src/pubspec.yaml .
                cp $src/pubspec.lock .
                chmod -R u+w ios

                flutter config --no-analytics &>/dev/null
                flutter config --enable-macos-desktop --enable-ios &>/dev/null
                flutter pub get --no-precompile --enforce-lockfile

                mkdir ios/scripts
                cp ${spCocoaLipoScript} ios/scripts/lipo
                patch -p1 < ${spCocoaIosLipoPatch}
                popd

                mkdir $GEM_HOME
                pushd $HOME/ios
                pod install
                rm Pods/Pods.xcodeproj/project.pbxproj
                rm Flutter/flutter_export_environment.sh
                rm Flutter/Generated.xcconfig
                find . -type d \( -name .symlinks -o \
                                  -name SpIcon.icon -o \
                                  -name xcuserdata \) -exec rm -rf {} + || true
                find Flutter/ephemeral/ -type -f -mindepth 1 -exec rm -f {} + || true
                popd
              '';

              installPhase = ''
                mkdir -p $out

                mv $HOME/ios $out/
                mv $HOME/.cocoapods $out/cocoapods
              '';
            };

            build-macos =
              let
                macosBuildScript = pkgs.writeShellApplication {
                  name = "macos-build-script";

                  runtimeInputs = with pkgs; [
                    spFlutter
                    spFlutter.dart
                    lndir
                    mktemp
                  ];

                  text = ''
                    shopt -s extglob

                    RELEASE="$1"

                    if [ "$#" -ne 1 ]; then
                      echo "Error: Exactly 1 argument is required: RELEASE. But you provided $#"
                      exit 1
                    fi

                    if [[ -z "$RELEASE" ]]; then
                      echo "Error: Arguments can't be empty strings"
                      exit 1
                    fi

                    if [[ ! "$RELEASE" == @(release|debug)  ]]; then
                        echo "Error: $RELEASE is not a valid macOS release type. Use either release or debug"
                        exit 1
                    fi

                    HOME="$(mktemp -d)"
                    XDG_CONFIG_HOME="$HOME/.config"
                    PUB_CACHE="$HOME/pubcache"
                    GEM_HOME="$HOME/gemcache"
                    export HOME XDG_CONFIG_HOME PUB_CACHE GEM_HOME

                    FLUTTER_BUILD_DIRECTORY="$HOME/builddir"
                    FLUTTER_NO_ANALYTICS=1
                    CI=true
                    export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

                    mkdir "$PUB_CACHE"
                    lndir -silent "${spFlutterDeps}" "$PUB_CACHE"

                    #cp -r "${spCocoaMacosDeps}/macos" "$HOME/"
                    cp -r "${spCocoaMacosDeps}/cocoapods" "$HOME/.cocoapods"
                    chmod -R u+r "$HOME/.cocoapods"

                    flutter config --no-analytics &>/dev/null
                    flutter config --enable-macos-desktop &>/dev/null
                    flutter pub get --offline --enforce-lockfile

                    # Build without signing (thus, without relying on /usr/bin/codesign)
                    cat >> macos/Runner/Configs/Release.xcconfig << EOF
                    CODE_SIGNING_ALLOWED=NO
                    CODE_SIGNING_REQUIRED=NO
                    CODE_SIGN_IDENTITY=
                    AD_HOC_CODE_SIGNING_ALLOWED=NO
                    EOF

                    flutter build macos --"$1" --no-pub
                  '';
                };
              in
              pkgs.stdenv.mkDerivation rec {
                name = "build-macos";
                phases = [ "installPhase" ];

                nativeBuildInputs = [ pkgs.makeWrapper ];

                installPhase = ''
                  mkdir -p $out/bin
                  cp ${macosBuildScript}/bin/${macosBuildScript.name} $out/bin/${name}
                  chmod +x $out/bin/${name}

                  wrapProgram $out/bin/${name} \
                    --set DEVELOPER_DIR "${spXcode}/Contents/Developer" \
                    --prefix PATH : "${spXcode}/Contents/Developer/usr/bin/" \
                    --prefix PATH : "${pkgs.lib.makeBinPath buildTools}"
                '';
              };

            build-ios =
              let
                iosBuildScript = pkgs.writeShellApplication {
                  name = "ios-build-script";

                  runtimeInputs = with pkgs; [
                    spFlutter
                    spFlutter.dart
                    lndir
                    mktemp
                  ];

                  text = ''
                    shopt -s extglob

                    TYPE="$1"
                    RELEASE="$2"

                    if [ "$#" -ne 2 ]; then
                      echo "Error: Exactly 2 arguments are required: TYPE and RELEASE. But you provided $#"
                      exit 1
                    fi

                    if [[ -z "$TYPE" || -z "$RELEASE" ]]; then
                      echo "Error: Arguments can't be empty strings"
                      exit 1
                    fi

                    if [[ ! "$TYPE" == @(ios|ipa)  ]]; then
                        echo "Error: $TYPE is not a valid Android target type. Use either ios or ipa"
                        exit 1
                    fi

                    if [[ ! "$RELEASE" == @(release|debug)  ]]; then
                        echo "Error: $RELEASE is not a valid Android release type. Use either release or debug"
                        exit 1
                    fi

                    HOME="$(mktemp -d)"
                    XDG_CONFIG_HOME="$HOME/.config"
                    PUB_CACHE="$HOME/pubcache"
                    GEM_HOME="$HOME/gemcache"
                    export HOME XDG_CONFIG_HOME PUB_CACHE GEM_HOME

                    FLUTTER_BUILD_DIRECTORY="$HOME/builddir"
                    FLUTTER_NO_ANALYTICS=1
                    CI=true
                    export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

                    mkdir "$PUB_CACHE"
                    lndir -silent "${spFlutterDeps}" "$PUB_CACHE"

                    #cp -r "${spCocoaIosDeps}/ios" "$HOME/"
                    cp -r "${spCocoaIosDeps}/cocoapods" "$HOME/.cocoapods"
                    chmod -R u+r "$HOME/.cocoapods"

                    flutter config --no-analytics &>/dev/null
                    flutter config --enable-ios &>/dev/null
                    flutter pub get --offline --enforce-lockfile

                    # Build without signing (thus, without relying on /usr/bin/codesign)
                    cat >> ios/Runner/Configs/Release.xcconfig << EOF
                    CODE_SIGNING_ALLOWED=NO
                    CODE_SIGNING_REQUIRED=NO
                    CODE_SIGN_IDENTITY=
                    AD_HOC_CODE_SIGNING_ALLOWED=NO
                    EOF

                    flutter build "$1" --"$2" --no-codesign --no-pub
                  '';
                };
              in
              pkgs.stdenv.mkDerivation rec {
                name = "build-ios";
                phases = [ "installPhase" ];

                nativeBuildInputs = [ pkgs.makeWrapper ];

                installPhase = ''
                  mkdir -p $out/bin
                  cp ${iosBuildScript}/bin/${iosBuildScript.name} $out/bin/${name}
                  chmod +x $out/bin/${name}

                  wrapProgram $out/bin/${name} \
                    --set DEVELOPER_DIR "${spXcode}/Contents/Developer" \
                    --prefix PATH : "${spXcode}/Contents/Developer/usr/bin/" \
                    --prefix PATH : "${pkgs.lib.makeBinPath buildTools}"
                '';
              };

            # sign-macos = null;
            # sign-ios = null;
            # deploy-macos = null;
            # deploy-ios = null;

            # Android packages and runnables
            build-android =
              let
                androidBuildScript = pkgs.writeShellApplication {
                  name = "android-build-script";

                  runtimeInputs = [
                    spFlutter
                    spFlutter.dart
                  ];

                  text = ''
                    shopt -s extglob

                    TYPE="$1"
                    RELEASE="$2"
                    FLAVOR="$3"

                    if [ "$#" -ne 3 ]; then
                      echo "Error: Exactly 3 arguments are required: TYPE, RELEASE, FLAVOR. But you provided $#"
                      exit 1
                    fi

                    if [[ -z "$TYPE" || -z "$RELEASE" || -z "$FLAVOR" ]]; then
                      echo "Error: Arguments can't be empty strings"
                      exit 1
                    fi

                    if [[ ! "$TYPE" == @(apk|aab)  ]]; then
                        echo "Error: $TYPE is not a valid Android target type. Use either apk or aab"
                        exit 1
                    fi

                    if [[ ! "$RELEASE" == @(release|debug)  ]]; then
                        echo "Error: $RELEASE is not a valid Android release type. Use either release or debug"
                        exit 1
                    fi

                    if [[ ! "$FLAVOR" == @(production|fdroid|nightly)  ]]; then
                        echo "Error: $FLAVOR is not a valid Android release type. Use either production, fdroid, or nightly"
                        exit 1
                    fi

                    HOME="$(mktemp -d)"
                    PUB_CACHE="$HOME/pubcache"
                    export HOME PUB_CACHE

                    FLUTTER_BUILD_DIRECTORY="$HOME/builddir"
                    FLUTTER_NO_ANALYTICS=1
                    CI=true
                    export FLUTTER_BUILD_DIRECTORY FLUTTER_NO_ANALYTICS CI

                    mkdir "$PUB_CACHE"
                    lndir -silent "${spFlutterDeps}" "$PUB_CACHE"

                    flutter config --no-analytics &>/dev/null
                    flutter config --enable-android &>/dev/null
                    flutter pub get --offline --enforce-lockfile
                    flutter build "$1" --"$2" --flavor "$3" --no-pub
                  '';
                };
              in
              pkgs.stdenv.mkDerivation rec {
                name = "build-android";
                phases = [ "installPhase" ];

                nativeBuildInputs = [ pkgs.makeWrapper ];

                installPhase = ''
                  mkdir -p $out/bin
                  cp ${androidBuildScript}/bin/${androidBuildScript.name} $out/bin/${name}
                  chmod +x $out/bin/${name}

                  wrapProgram $out/bin/${name} \
                    --set JAVA_HOME "${spJava.home}" \
                    --set ANDROID_HOME "${spAndroidSDK.androidsdk}/libexec/android-sdk" \
                    --set ANDROID_SDK_ROOT "${spAndroidSDK.androidsdk}/libexec/android-sdk" \
                    --set ANDROID_NDK_HOME "${spAndroidSDK.androidsdk}/libexec/android-sdk/ndk" \
                    --prefix PATH : "${pkgs.lib.makeBinPath (buildTools ++ buildLibs)}" \
                    --prefix PKG_CONFIG_PATH : "${
                      pkgs.lib.makeSearchPathOutput "dev" "lib/pkgconfig" (buildTools ++ buildLibs)
                    }" \
                    --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath (buildTools ++ buildLibs)}"
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
          };

          # Converts a list of runnable names into Nix applications to `nix run`
          apps = lib.genAttrs spRunnables (name: {
            type = "app";
            program = "${self'.packages.${name}}/bin/${name}";
          });

          devShells = {
            # Generic shells
            analyze = pkgs.mkShell { nativeBuildInputs = analyzeTools; };

            scan = pkgs.mkShell { nativeBuildInputs = scannerTools; };

            test = pkgs.mkShell { nativeBuildInputs = testTools; };

            sign = pkgs.mkShell { nativeBuildInputs = signTools; };

            fdroid = pkgs.mkShell { nativeBuildInputs = fdroidTools; };

            # Linux shells
            linux-precached = pkgs.mkShell {
              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;

              shellHook = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE="$HOME/pubcache"
                export FLUTTER_ROOT="${spFlutter}"

                mkdir $PUB_CACHE
                lndir -silent ${spFlutterDeps} $PUB_CACHE

                mkdir $HOME/builddir
                lndir -silent ${spProjectFiles} $HOME/builddir
                cd $HOME/builddir
              '';
            };

            linux = pkgs.mkShell {
              nativeBuildInputs = buildTools;
              buildInputs = buildLibs;

              shellHook = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE="$HOME/pubcache"
                export FLUTTER_ROOT="${spFlutter}"
              '';
            };

            linux-flatpak = pkgs.mkShell {
              nativeBuildInputs = flatpakTools;

              shellHook = ''
                export HOME=$(mktemp -d)
              '';
            };

            linux-appimage = pkgs.mkShell {
              nativeBuildInputs = appimageTools;

              shellHook = ''
                export HOME=$(mktemp -d)
              '';
            };

            # Android shells
            android-precached = pkgs.mkShell {
              nativeBuildInputs = buildTools ++ androidBuildTools;

              shellHook = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE="$HOME/pubcache"
                export FLUTTER_ROOT="${spFlutter}"

                export JAVA_HOME="${spJava.home}"
                export ANDROID_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_SDK_ROOT="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_NDK_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk/ndk"

                mkdir $PUB_CACHE
                lndir -silent ${spFlutterDeps} $PUB_CACHE

                mkdir $HOME/builddir
                lndir -silent ${spProjectFiles} $HOME/builddir
                cd $HOME/builddir
              '';
            };

            android = pkgs.mkShell {
              nativeBuildInputs = buildTools ++ androidBuildTools;

              shellHook = ''
                export HOME=$(mktemp -d)
                export PUB_CACHE="$HOME/pubcache"
                export FLUTTER_ROOT="${spFlutter}"

                export JAVA_HOME="${spJava.home}"
                export ANDROID_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_SDK_ROOT="${spAndroidSDK.androidsdk}/libexec/android-sdk"
                export ANDROID_NDK_HOME="${spAndroidSDK.androidsdk}/libexec/android-sdk/ndk"
              '';
            };

            # Darwin shells
            macos-precached = pkgs.mkShellNoCC {
              nativeBuildInputs = buildTools;

              shellHook = ''
                export HOME="$(mktemp -d)"
                export PUB_CACHE="$HOME/pubcache"
                export GEM_HOME="$HOME/gemcache"
                export FLUTTER_ROOT="${spFlutter}"

                export DEVELOPER_DIR="${spXcode}"
                export PATH="${spXcode}/Contents/Developer/usr/bin/:$PATH"

                mkdir $PUB_CACHE
                lndir -silent ${spFlutterDeps} $PUB_CACHE

                mkdir $HOME/builddir
                lndir -silent ${spProjectFiles} $HOME/builddir
                rm -rf $HOME/builddir/macos $HOME/builddir/build
                #cp -r ${spCocoaMacosDeps}/macos $HOME/builddir/
                cp -r ${spCocoaMacosDeps}/cocoapods $HOME/.cocoapods
                chmod -R u+w $HOME/builddir/macos $HOME/.cocoapods
                cd $HOME/builddir
              '';
            };

            macos = pkgs.mkShellNoCC {
              nativeBuildInputs = buildTools;

              shellHook = ''
                export HOME="$(mktemp -d)"
                export PUB_CACHE="$HOME/pubcache"
                export GEM_HOME="$HOME/gemcache"
                export FLUTTER_ROOT="${spFlutter}"

                export DEVELOPER_DIR="${spXcode}"
                export PATH="${spXcode}/Contents/Developer/usr/bin/:$PATH"
              '';
            };

            ios-precached = pkgs.mkShellNoCC {
              nativeBuildInputs = buildTools;

              shellHook = ''
                export HOME="$(mktemp -d)"
                export PUB_CACHE="$HOME/pubcache"
                export GEM_HOME="$HOME/gemcache"
                export FLUTTER_ROOT="${spFlutter}"

                export DEVELOPER_DIR="${spXcode}/Contents/Developer"
                export PATH="${spXcode}/Contents/Developer/usr/bin/:$PATH"

                mkdir $PUB_CACHE
                lndir -silent ${spFlutterDeps} $PUB_CACHE

                mkdir $HOME/builddir
                lndir -silent ${spProjectFiles} $HOME/builddir
                rm -rf $HOME/builddir/ios $HOME/builddir/build
                #cp -r ${spCocoaIosDeps}/ios $HOME/builddir/
                cp -r ${spCocoaIosDeps}/cocoapods $HOME/.cocoapods
                chmod -R u+w $HOME/builddir/ios $HOME/.cocoapods
                cp -r ${spProjectFiles}/ios/SpIcon.icon $HOME/builddir/ios/
                chmod -R u+w $HOME/builddir/ios/SpIcon.icon
                cd $HOME/builddir
              '';
            };

            ios = pkgs.mkShellNoCC {
              nativeBuildInputs = buildTools;

              shellHook = ''
                export HOME="$(mktemp -d)"
                export PUB_CACHE="$HOME/pubcache"
                export GEM_HOME="$HOME/gemcache"
                export FLUTTER_ROOT="${spFlutter}"

                export DEVELOPER_DIR="${spXcode}/Contents/Developer"
                export PATH="${spXcode}/Contents/Developer/usr/bin/:$PATH"
              '';
            };
          };
        };
    };
}
