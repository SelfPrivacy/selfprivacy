{ pkgs, sp, ... }:

let
  commitSDK = "0cc82216a407cc993941b5ddabd446becc3c9a6219d9bcf50125c60101dcad46";
  commitRuntime = "d27f7a6a974e40b061070bec1be9e1b52a7a6872b271e6a45c2c34a48bf6fedf";
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
  outputHash = "sha256-bz3RC1o4l3z8iCdUdFZKjju4qEc8PWgt8KQTu1MjL1Y=";

  builder = pkgs.writeShellScript "fetch-flatpak-sdk" ''
    export HOME="$NIX_BUILD_TOP"
    export FLATPAK_USER_DIR="$HOME/flatpak"

    mkdir -p $out/repo
    ostree init --repo=$out/ --mode=archive
    ostree remote --repo=$out/ add --set=gpg-verify=false flathub https://dl.flathub.org/repo/
    ostree pull --repo=$out/ --mirror --depth=0 --http-header=User-Agent=SelfPrivacy-flatpak-sdk/${version} flathub runtime/org.freedesktop.Sdk/${sp.shortSystem}/${version}@${commitSDK}
    ostree pull --repo=$out/ --mirror --depth=0 --http-header=User-Agent=SelfPrivacy-flatpak-sdk/${version} flathub runtime/org.freedesktop.Platform/${sp.shortSystem}/${version}@${commitRuntime}
  '';
}
