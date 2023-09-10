{
  nixConfig.bash-prompt = "\[selfprivacy\]$ ";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixgl.url = "github:guibou/nixGL";

  outputs = { self, nixpkgs, flake-utils, nixgl }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.android_sdk.accept_license = true;
          overlays = [ nixgl.overlay ];
        };

        androidComposition = pkgs.androidenv.composeAndroidPackages {
          platformToolsVersion = "34.0.4";
          buildToolsVersions = [ "34.0.0" ];
          platformVersions = [ "34" "33" "32" "31" "30" ];
        };

        spAndroidStudio = pkgs.symlinkJoin {
           name = "spAndroidStudio";
           paths = with pkgs; [
             android-studio
             flutter.unwrapped
             # dart
             gnumake
             check
             pkg-config
             glibc
             android-tools
             jdk
             git
           ];

           nativeBuildInputs = [ pkgs.makeWrapper ];
           postBuild = ''
             wrapProgram $out/bin/flutter \
               --prefix ANDROID_SDK_ROOT=${androidComposition.androidsdk}/libexec/android-sdk \
               --prefix ANDROID_HOME=${androidComposition.androidsdk}/libexec/android-sdk \
               --prefix ANDROID_JAVA_HOME=${pkgs.jdk.home}

             wrapProgram $out/bin/android-studio \
               --prefix FLUTTER_SDK=${pkgs.flutter.unwrapped} \
               --prefix ANDROID_SDKz_ROOT=${androidComposition.androidsdk}/libexec/android-sdk \
               --prefix ANDROID_HOME=${androidComposition.androidsdk}/libexec/android-sdk \
               --prefix ANDROID_JAVA_HOME=${pkgs.jdk.home}
           '';
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
          flutter.unwrapped
          bash
          curl
          flutter.dart
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
        ];

        releaseDerivation = pkgs.flutter.mkFlutterApp rec {
            pname = "selfprivacy";
            version = "0.6.0";

            vendorHash = "sha256-7cbiAyIlaz3HqEsZN/nZxaLZjseJv5CmiIHqsoGa4ZI=";

            nativeBuildInputs = [ pkgs.nixgl.auto.nixGLDefault ];

            src = ./.;

            desktopItem = pkgs.makeDesktopItem {
              name = "${pname}";
              exec = "@out@/bin/${pname}";
              desktopName = "SelfPrivacy";
            };

            postInstall = ''
              rm $out/bin/$pname

              printf "#!/bin/sh\n${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL $out/app/${pname}" > $out/bin/$pname
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
