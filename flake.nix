{
  nixConfig.bash-prompt = "\[selfprivacy\]$ ";

  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/c1ce56e9c606b4cd31f0950768911b1171b8db51";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        lib = nixpkgs.lib;

        fromYAML = path: lib.importJSON (pkgs.runCommand "yml2json" { nativeBuildInputs = [pkgs.yq]; src = path; } ''cat $src | yq . > $out'');

        pubSpec = fromYAML ./pubspec.yaml;

        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.android_sdk.accept_license = true;
        };

        spFlutter = pkgs.flutter332;

        androidComposition = pkgs.androidenv.composeAndroidPackages {
          platformToolsVersion = "34.0.4";
          buildToolsVersions = [ "34.0.0" ];
          platformVersions = [ "34" "33" "32" "31" "30" ];
        };

        buildDeps = with pkgs; [
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
        ];

        nativeBuildDeps = with pkgs; [
          spFlutter
          spFlutter.dart
          bash
          curl
          git
          unzip
          which
          xz
          cmake
          ninja
          pkg-config
          wrapGAppsHook
          autoPatchelfHook
          androidComposition.androidsdk
          openjdk11_headless
          clang
          xdg-user-dirs
        ];

        releaseDerivation = spFlutter.buildFlutterApplication rec {
            pname = pubSpec.name;
            version = pubSpec.version;

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
      in
      {
        packages = {
          release = releaseDerivation;
        };
        defaultPackage = releaseDerivation;

        devShell = pkgs.mkShell {
          buildInputs = buildDeps;
          nativeBuildInputs = nativeBuildDeps;

          JAVA_HOME = "${pkgs.openjdk11_headless.home}";
          ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
          ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";

          NIX_LDFLAGS = "-rpath ${pkgs.lib.makeLibraryPath buildDeps}";
          NIX_CFLAGS_COMPILE = "-I${pkgs.xorg.libX11}/include";
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildDeps;

          shellHook = ''
            export TMP=$(mktemp -d)
            export HOME="$TMP"
            export PUB_CACHE=''${PUB_CACHE:-"$HOME/.pub-cache"}
            export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
          '';
        };
      });
}
