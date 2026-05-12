{
  pkgs,
  sp,
  lib,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "${sp.applicationMetadata.name}-flutter-deps";
  version = sp.applicationMetadata.version;
  src = lib.fileset.toSource {
    root = ../../.;
    fileset = lib.fileset.unions [
      ../../pubspec.yaml
      ../../pubspec.lock
    ];
  };

  nativeBuildInputs = sp.buildTools;

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
    mkdir $out

    cp -r $PUB_CACHE/. $out/
  '';
}
