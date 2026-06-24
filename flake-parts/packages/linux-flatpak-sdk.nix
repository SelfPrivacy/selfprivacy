{ pkgs, sp, ... }:

let
  commitSDK = "43f98359f53fb32d84218462532c8db7e28f1e5246f2c185e8f695908ce98157";
  commitRuntime = "3f0cb4a807750a19ed8a3dea96be9bf562271bd8e84137fb2d678e665b549b73";
in
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "${sp.applicationMetadata.name}-flatpak-sdk";
  version = "25.08";

  meta = {
    platforms = [ "x86_64-linux" ];
  };

  nativeBuildInputs = sp.flatpakTools;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-ywXEtfGnU4Z9XOOk8/psWkdHUSPLa+xYNluRjTS9uyI=";

  builder = pkgs.writeShellScript "fetch-flatpak-sdk" ''
    export HOME="$NIX_BUILD_TOP"
    export FLATPAK_USER_DIR="$HOME/flatpak"

    mkdir -p $out/repo
    ostree init --repo=$out/ --mode=archive
    ostree remote --repo=$out/ add --set=gpg-verify=false flathub https://dl.flathub.org/repo/
    ostree pull --repo=$out/ --mirror --depth=0 flathub runtime/org.freedesktop.Sdk/${sp.shortSystem}/${version}@${commitSDK}
    ostree pull --repo=$out/ --mirror --depth=0 flathub runtime/org.freedesktop.Platform/${sp.shortSystem}/${version}@${commitRuntime}
  '';
}
