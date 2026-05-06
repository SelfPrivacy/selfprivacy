{
  pkgs,
  sp,
  ...
}:

let
  commitSDK = "94938f2e7cc692b9c95f64a972e92528598979ff72daf4af8b463c3d8878d7e5";
  commitRuntime = "1937643312594be1a9f3839b7c7c14f9d8fe123653bb03f4df42fa66dd7f917c";
in
pkgs.stdenv.mkDerivation rec {
  pname = "${sp.applicationMetadata.name}-flatpak-sdk";
  version = "25.08";

  nativeBuildInputs = sp.flatpakTools;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-E+eba/cTugIi0iR1eC+AovpBZagTf1pcAoDX3p+XesU=";

  builder = pkgs.writeShellScript "fetch-flatpak-sdk" ''
    export HOME=$TMPDIR
    export FLATPAK_USER_DIR=$HOME/flatpak

    mkdir -p $out/repo
    ostree init --repo=$out/ --mode=archive
    ostree remote --repo=$out/ add --set=gpg-verify=false flathub https://dl.flathub.org/repo/
    ostree pull --repo=$out/ --mirror --depth=0 flathub runtime/org.freedesktop.Sdk/${sp.shortSystem}/${version}@${commitSDK}
    ostree pull --repo=$out/ --mirror --depth=0 flathub runtime/org.freedesktop.Platform/${sp.shortSystem}/${version}@${commitRuntime}
  '';
}
