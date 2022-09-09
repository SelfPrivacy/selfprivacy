#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset -x

CONTAINER_IMAGE="localhost/flutter-build-env"
OPTS=$(getopt -o "" --long "build-linux,build-apk,sign-apk-standalone,sign-apk-fdroid,package-linux-appimage,package-linux-flatpak,package-linux-archive" -- "$@")
eval set -- "$OPTS"

usage () {
  echo "Usage: $0 [--build-linux] [--build-apk] [--sign-apk-standalone] [--sign-apk-fdroid] [--package-linux-appimage] [--package-linux-flatpak] [--package-linux-archive]" 1>&2; exit 1;
}

podman_offline () {
  podman run --rm -v "`pwd`:/var/lib/builder/src:U" -v "/var/lib/drone-runner-exec/fdroid:/var/lib/builder/repo:U" -v "/var/lib/drone-runner-exec/fdroid-keystore:/var/lib/builder/repo/fdroid-keystore:U" -v "/var/lib/drone-runner-exec/standalone-keystore:/var/lib/builder/repo/standalone-keystore:U" --env FDROID_KEYSTORE_PASS="$FDROID_KEYSTORE_PASS" --env STANDALONE_KEYSTORE_PASS="$STANDALONE_KEYSTORE_PASS" --network=none --workdir $1 "$CONTAINER_IMAGE" $2
}

podman_online () {
  podman run --rm -v "`pwd`:/var/lib/builder/src:U" --privileged --workdir $1 "$CONTAINER_IMAGE" $2
}

build_linux () {
  podman_offline "/var/lib/builder/src" "flutter pub get --offline"
  podman_offline "/var/lib/builder/src" "flutter build linux -v"
}

build_apk () {
  podman_offline "/var/lib/builder/src" "flutter pub get --offline"
  podman_offline "/var/lib/builder/src" "flutter build apk -v"
}

sign_apk_standalone () {
  podman_offline "/var/lib/builder/repo" "cp /var/lib/builder/src/build/app/outputs/flutter-apk/app-release.apk ."
  podman_offline "/var/lib/builder/repo" "zipalign -f -v 4 app-release.apk standalone_app-release.apk"
  podman_offline "/var/lib/builder/repo" "apksigner sign --ks /var/lib/builder/repo/standalone-keystore --ks-key-alias standalone --ks-pass env:STANDALONE_KEYSTORE_PASS standalone_app-release.apk"
}

sign_apk_fdroid () {
  podman_offline "/var/lib/builder/repo" "cp /var/lib/builder/src/build/app/outputs/flutter-apk/app-release.apk unsigned/"
}

package_linux_appimage () {
  podman_online "/var/lib/builder/src" "appimage-builder --recipe appimage.yml"
}

package_linux_flatpak () {
  podman_online "/var/lib/builder/src" "flatpak-builder --disable-rofiles-fuse --force-clean --repo=flatpak-repo flatpak-build flatpak.yml"
  podman_online "/var/lib/builder/src" "flatpak build-bundle flatpak-repo selfprivacy.flatpak pro.kherel.selfprivacy"
}

package_linux_archive () {
  podman_online "/var/lib/builder/src" "tar -C build/linux/x64/release/bundle -vacf selfprivacy.tar.zstd ."
}

while true; do
  case "$1" in
    --build-linux )
      build_linux
      ;;
    --build-apk )
      build_apk
      ;;
    --sign-apk-standalone )
      sign_apk_standalone
      ;;
    --sign-apk-fdroid )
      sign_apk_fdroid
      ;;
    --package-linux-appimage )
      package_linux_appimage
      ;;
    --package-linux-flatpak )
      package_linux_flatpak
      ;;
    --package-linux-archive )
      package_linux_archive
      ;;
    *)
      usage
      ;;
  esac
  shift
done
