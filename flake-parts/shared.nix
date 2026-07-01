{ ... }:
{
  perSystem =
    {
      self',
      pkgs,
      lib,
      system,
      ...
    }:
    {
      _module.args.sp = rec {
        # What actually is needed to be passed during the build
        projectFiles = lib.fileset.toSource {
          root = ../.;
          fileset = lib.fileset.unions [
            ../android
            ../assets
            ../ios
            ../lib
            ../linux
            ../macos
            ../pubspec.lock
            ../pubspec.yaml
            ../nfpm.yaml
            ../selfprivacy.desktop
            ../selfprivacy.metainfo.xml
            ../test
          ];
        };

        # Project named files and metadata
        applicationNix = self'.packages.linux-nix;
        applicationGeneric = self'.packages.linux-generic;
        applicationPortable = self'.packages.linux-portable;
        applicationMetadata = toNixFromYAML ../pubspec.yaml;

        buildroot = self'.packages.linux-buildroot;
        buildrootDeps = self'.packages.linux-buildroot-deps;
        buildrootPixiPack = pkgs.stdenvNoCC.mkDerivation {
          name = "pixi-pack";

          src = pkgs.fetchurl {
            url = "https://github.com/Quantco/pixi-pack/releases/download/v0.7.8/pixi-pack-x86_64-unknown-linux-musl";
            hash = "sha256-Wr0lJo/nJfeX5FkpwALYQ+eErrBubpve2Xbb8h7qxHA=";
          };

          phases = [ "installPhase" ];

          installPhase = ''
            mkdir -p $out/bin

            cp $src $out/bin/pixi-pack
            chmod a+x $out/bin/pixi-pack
          '';
        };
        buildrootPixiUnpack = pkgs.stdenvNoCC.mkDerivation {
          name = "pixi-unpack";

          src = pkgs.fetchurl {
            url = "https://github.com/Quantco/pixi-pack/releases/download/v0.7.8/pixi-unpack-x86_64-unknown-linux-musl";
            hash = "sha256-S+a9Ur1VYwIgXW1wdQrb23+4ctamX0iY6CU7itB5lWA=";
          };

          phases = [ "installPhase" ];

          installPhase = ''
            mkdir -p $out/bin

            cp $src $out/bin/pixi-unpack
            chmod a+x $out/bin/pixi-unpack
          '';
        };
        buildrootPixiFiles = lib.fileset.toSource {
          root = ../ci/.;
          fileset = lib.fileset.unions [
            ../ci/pixi.toml
            ../ci/pixi.lock
            ../ci/setup.sh
          ];
        };
        buildrootPixiLockfile = ../ci/pixi.lock;

        flutterDeps = self'.packages.flutter-deps;
        flutterPubspec = ../pubspec.yaml;
        flutterLockfile = ../pubspec.lock;
        flutterParsedLockfile = toNixFromYAML flutterLockfile;

        androidGradleDeps = self'.packages.android-gradle-deps;

        cocoaMacosDeps = self'.packages.macos-cocoa-deps;
        cocoaIosDeps = self'.packages.ios-cocoa-deps;
        cocoaMacosLipoPatch = ../ci/darwin/project.pbxproj.macos.patch;
        cocoaIosLipoPatch = ../ci/darwin/project.pbxproj.ios.patch;
        cocoaLipoScript = ../ci/darwin/lipo;

        flatpakManifestFile = ../ci/flatpak/flatpak-nix.yml;
        flatpakSDK = self'.packages.linux-flatpak-sdk;

        desktopFile = ../selfprivacy.desktop;
        appstreamFile = ../selfprivacy.metainfo.xml;
        iconPNGFile = ../assets/images/icon/logo_512.png;
        iconSVGFile = ../assets/images/icon/logo.svg;

        # `nix run` applications
        runnables = [
          "test-flutter"
          "analyze-flutter"
          "scan-sonarqube"
          "pubspec-deps-json"

          "build-ios"

          # "sign-android"
          # "sign-macos"
          # "sign-ios"

          # "deploy-android"
          # "deploy-macos"
          # "deploy-ios"
        ];

        # Named dependencies
        ourJava = pkgs.openjdk17_headless;
        ourXcode = pkgs.darwin.xcode_26_1_Apple_silicon;
        ourFlutter = pkgs.flutter335;
        ourAndroidSDK = pkgs.androidenv.composeAndroidPackages {
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
            ourFlutter
            ourFlutter.dart
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
          ++ lib.optionals stdenvNoCC.isLinux [

            clang
            cmake
            ninja
            pkg-config
            libsecret
          ]
          ++ lib.optionals stdenvNoCC.isDarwin [
            ruby
            cocoapods
            rsync
            darwin.DarwinTools
            darwin.sigtool
            xcbuild
          ];

        androidBuildTools = with pkgs; [
          ourAndroidSDK.androidsdk
          ourJava
          ourGradle8111Wrapped
        ];

        buildLibs =
          with pkgs;
          [ ]
          ++
            lib.optionals stdenvNoCC.isLinux

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
              ]
          ++ lib.optionals stdenvNoCC.isDarwin [ ];

        signTools = with pkgs; [
          ourJava
          apksigner
          fastlane
        ];

        fdroidTools = with pkgs; [ fdroidserver ];

        analyzeTools = [
          ourFlutter
          ourFlutter.dart
        ];

        scannerTools = (with pkgs; [ sonar-scanner-cli ]) ++ analyzeTools;

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
          ourAppImageTool
          ourAppImageRuntime
          which
        ];

        archiveTools = with pkgs; [
          gnutar
          xz
          patchelf
        ];

        testTools = [
          ourFlutter
          ourFlutter.dart
        ];

        # Handy functions, variables, and utilities
        toNixFromYAML =
          path:
          lib.importJSON (
            pkgs.runCommand "yml2json" {
              nativeBuildInputs = [ pkgs.yq ];
              src = path;
            } "cat $src | yq . > $out"
          );
        toYAMLFromJSON =
          path:
          pkgs.runCommand "json2yml" {
            nativeBuildInputs = [ pkgs.yq ];
            src = path;
          } "yq -P $src > $out";

        shortSystem = builtins.head (lib.strings.splitString "-" system);

        ourAppImageTool = pkgs.appimageTools.wrapType2 {
          pname = "appimagetool";
          version = "1.9.1";

          src = pkgs.fetchurl {
            url = "https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage";
            hash = "sha256-7UzoTw2cr/ZvULzKb/bzWq5UzoE1QIs/ozq/w8s4TrA=";
          };
        };

        ourAppImageRuntime = pkgs.stdenvNoCC.mkDerivation rec {
          pname = "appimage-runtime";
          version = "20260624";

          src = pkgs.fetchurl {
            url = "https://github.com/AppImage/type2-runtime/releases/download/continuous/runtime-x86_64";
            hash = "sha256-HMSbzx4szVk8N5rbF8n4WjbWGQiCllBN6VsdBiFa678=";
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

        ourGradle8111 = pkgs.gradle-packages.mkGradle {
          version = "8.11.1";
          hash = "sha256-85eyhwI6zboen2/F6nLSLdY2adWe1KKJopsadu7hUcY=";
          defaultJava = ourJava;
        };

        ourGradle8111Wrapped = ourGradle8111.passthru.wrapped;
      };
    };
}
