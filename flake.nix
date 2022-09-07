{
  nixConfig.bash-prompt = "\[selfprivacy\]$ ";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixgl.url = "github:guibou/nixGL";

  outputs = { self, nixpkgs, flake-utils, nixgl }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          config.android_sdk.accept_license = true;
          system = "x86_64-linux";
          overlays = [ nixgl.overlay ];
        };

        androidComposition = pkgs.androidenv.composeAndroidPackages {
          toolsVersion = "26.1.1";
          platformToolsVersion = "33.0.2";
          buildToolsVersions = [ "30.0.3" ];
          platformVersions = [ "31" "30" "29" ];
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
