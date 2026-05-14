# Preserved for historical and educational reasons to show Nix-native
# way to install Conda packages from a Pixi lockfile.
#
# We use pixi-pack and pixi-unpack instead

{
  pkgs,
  sp,
  lib,
  ...
}:

let
  pixiLockfile = sp.toNixFromYAML sp.buildrootPixiLockfile;

  allPackagesByUrl = lib.listToAttrs (
    map (package: lib.nameValuePair package.conda package) pixiLockfile.packages
  );

  environmentPackages = lib.filter (
    package: package ? conda
  ) pixiLockfile.environments.default.packages.linux-64;

  condaPackages = map (package: allPackagesByUrl.${package.conda}) environmentPackages;

  getSubdir = package: if lib.hasInfix "/noarch/" package.conda then "noarch" else "linux-64";

  hashToSri =
    hex:
    builtins.convertHash {
      hash = "sha256:${hex}";
      toHashFormat = "sri";
    };

  parseStem =
    url:
    let
      filename = builtins.baseNameOf url;
      stem =
        if lib.hasSuffix ".conda" filename then
          lib.removeSuffix ".conda" filename
        else
          lib.removeSuffix ".tar.bz2" filename;
      parts = lib.splitString "-" stem;
      count = builtins.length parts;
      build = builtins.elemAt parts (count - 1);
      version = builtins.elemAt parts (count - 2);
      name = builtins.concatStringsSep "-" (lib.sublist 0 (count - 2) parts);
    in
    {
      inherit name version build;
    };

  makePackageDerivation = package: {
    drv = pkgs.fetchurl {
      url = package.conda;
      hash = hashToSri package.sha256;
      name = builtins.baseNameOf package.conda;
    };
    subdir = getSubdir package;
  };

  packageDerivations = map makePackageDerivation condaPackages;

  repoEntry =
    package:
    let
      parsed = parseStem package.conda;
    in
    lib.nameValuePair (builtins.baseNameOf package.conda) (
      lib.filterAttrs (_: value: value != null) {
        name = package.name or parsed.name;
        version = package.version or parsed.version;
        build = package.build or parsed.build;
        build_number = package.build_number or 0;
        sha256 = package.sha256 or null;
        md5 = package.md5 or null;
        depends = package.depends or [ ];
        constrains = package.constrains or [ ];
        license = package.license or null;
        size = package.size or null;
        timestamp = package.timestamp or null;
        subdir = getSubdir package;
      }
    );

  makeRepodata =
    subdir:
    let
      subdirPackages = lib.filter (package: getSubdir package == subdir) condaPackages;
      tarPackages = lib.filter (package: !lib.hasSuffix ".conda" package.conda) subdirPackages;
      condaFormatPackages = lib.filter (package: lib.hasSuffix ".conda" package.conda) subdirPackages;
    in
    builtins.toJSON {
      info = { inherit subdir; };
      packages = lib.listToAttrs (map repoEntry tarPackages);
      "packages.conda" = lib.listToAttrs (map repoEntry condaFormatPackages);
      repodata_version = 1;
    };
in
pkgs.stdenvNoCC.mkDerivation {
  name = "create-conda-repo";

  phases = [ "installPhase" ];

  repodataLinux64 = makeRepodata "linux-64";
  repodataNoarch = makeRepodata "noarch";

  installPhase = ''
    mkdir -p $out/linux-64 $out/noarch

    ${lib.concatMapStrings (
      { drv, subdir }:
      ''
        cp ${drv} $out/${subdir}/${drv.name}
      ''
    ) packageDerivations}

    echo "$repodataLinux64" > $out/linux-64/repodata.json
    echo "$repodataNoarch"  > $out/noarch/repodata.json

  '';
}
