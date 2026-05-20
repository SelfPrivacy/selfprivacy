{ sp, pkgs, ... }:
let
  lockfileJSON = builtins.toFile "pubspec-lock.json" (
    builtins.toJSON (sp.toNixFromYAML sp.flutterLockfile)
  );
in
sp.ourFlutter.buildFlutterApplication {
  pname = "${sp.applicationMetadata.name}-flutter-deps";
  version = sp.applicationMetadata.version;

  nativeBuildInputs = with pkgs; [
    jq
    yq-go
    git
  ];

  src = sp.projectFiles;

  gitHashes = {
    "sp_cubit_form" = "sha256-fq3NimMBwrR4zEQOq/cW7Kn/raaIaqDgaZ5CbENhJMM=";
  };

  pubspecLock = sp.toNixFromYAML sp.flutterLockfile;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out $debug

    cp -r .dart_tool $out/

    mkdir -p $out/pubcache/{hosted,hosted-hashes}/pub.dev

    # Compile packages metadata
    jq -r '.packages[] | [.name, .rootUri] | @tsv' .dart_tool/package_config.json > package-paths.tsv
    jq -r '.packages | to_entries[] | select(.value.source == "hosted") | [.key, .value.version, .value.description.sha256] | @tsv' ${lockfileJSON} > hosted.tsv

    # Create a symlink tree to mimic the $PUB_CACHE directory structure
    while IFS=$'\t' read -r name version sha256; do
      rootUri="$(awk -F '\t' -v pkg="$name" '$1 == pkg { print $2 }' package-paths.tsv)"
      rootPath="''${rootUri#file://}"
      rootPath="''${rootPath%/.}"

      ln -s $rootPath $out/pubcache/hosted/pub.dev/$name-$version

      printf "%s" "$sha256" > $out/pubcache/hosted-hashes/pub.dev/$name-$version.sha256
    done < hosted.tsv

    # Rewrite Git dependencies to Nix store paths
    cp ${sp.flutterLockfile} pubspec.lock
    cp ${sp.flutterPubspec} pubspec.yaml

    jq -r '.packages | to_entries[] | select(.value.source == "git") | .key' ${lockfileJSON} | \
      while read -r name; do
        rootUri="$(jq -r --arg name "$name" '.packages[] | select(.name == $name) | .rootUri' .dart_tool/package_config.json)"
        rootPath="''${rootUri#file://}"
        rootPath="''${rootPath%/.}"

        yq -i "
          .packages[\"$name\"].source = \"path\" |
          .packages[\"$name\"].description.path = \"$rootPath\" |
          .packages[\"$name\"].description.relative = false |
          del(.packages[\"$name\"].description.ref) |
          del(.packages[\"$name\"].description.resolved-ref) |
          del(.packages[\"$name\"].description.url)
        " pubspec.lock

        yq -i "del(.dependencies[\"$name\"].git) | .dependencies[\"$name\"].path = \"$rootPath\" " pubspec.yaml
    done

    cp pubspec.lock pubspec.yaml $out/

    runHook postInstall
  '';
}
