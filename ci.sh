#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset -x

CONTAINER_IMAGE="localhost/flutter-build-env"
APP_NAME="pro.kherel.selfprivacy"
APP_VERSION_FULL="$(yq '.version' pubspec.yaml)"
APP_SEMVER="$(printf $APP_VERSION_FULL | cut -d '+' -f1)"
APP_BUILD_ID="$(printf $APP_VERSION_FULL | cut -d '+' -f2)"

OPTS=$(getopt -o "" --long "build-linux,build-apk,sign-apk-standalone,sign-apk-fdroid,package-linux-appimage,package-linux-flatpak,package-linux-archive" -- "$@")
eval set -- "$OPTS"

usage () {
  echo "Usage: $0 [--build-linux] [--build-apk] [--sign-apk-standalone] [--sign-apk-fdroid] [--package-linux-appimage] [--package-linux-flatpak] [--package-linux-archive]" 1>&2; exit 1;
}

podman_offline () {
  podman run --rm -v "src:/var/lib/builder/src:U" -v "/var/lib/drone-runner-exec/fdroid:/var/lib/builder/fdroid:U" -v "/var/lib/drone-runner-exec/fdroid-keystore:/var/lib/builder/fdroid/fdroid-keystore:U" -v "/var/lib/drone-runner-exec/standalone-keystore:/var/lib/builder/fdroid/standalone-keystore:U" --env FDROID_KEYSTORE_PASS="$FDROID_KEYSTORE_PASS" --env STANDALONE_KEYSTORE_PASS="$STANDALONE_KEYSTORE_PASS" --network=none --workdir $1 "$CONTAINER_IMAGE" $2
}

podman_online () {
  podman run --rm -v "src:/var/lib/builder/src:U" --privileged --workdir $1 "$CONTAINER_IMAGE" $2
}

build_linux () {
  podman_offline "/var/lib/builder/src" "flutter pub get --offline"
  podman_offline "/var/lib/builder/src" "flutter build linux"
}

build_apk () {
  podman_offline "/var/lib/builder/src" "flutter pub get --offline"
  podman_offline "/var/lib/builder/src" "flutter build apk"
}

sign_apk_standalone () {
  podman_offline "/var/lib/builder/fdroid" "zipalign -f -v 4 ../src/build/app/outputs/flutter-apk/app-release.apk standalone_"$APP_NAME"-"$APP_SEMVER".apk"
  podman_offline "/var/lib/builder/fdroid" "apksigner sign --ks standalone-keystore --ks-key-alias standalone --ks-pass env:STANDALONE_KEYSTORE_PASS standalone_"$APP_NAME"-"$APP_SEMVER".apk"
}

sign_apk_fdroid () {
  podman_offline "/var/lib/builder/fdroid" "sh -c "if [[ ! -f repo/"$APP_NAME"_"$APP_BUILD_ID".apk ]]; then cp ../src/build/app/outputs/flutter-apk/app-release.apk unsigned; fi""
  podman_offline "/var/lib/builder/fdroid" "fdroid publish"
  podman_offline "/var/lib/builder/fdroid" "fdroid update"
}

package_linux_appimage () {
  podman_online "/var/lib/builder/src" "appimage-builder --recipe appimage.yml"
}

package_linux_flatpak () {
  podman_online "/var/lib/builder/src" "flatpak-builder --disable-rofiles-fuse --force-clean --repo=flatpak-repo flatpak-build flatpak.yml"
  podman_online "/var/lib/builder/src" "flatpak build-bundle flatpak-repo $APP_NAME-$APP_SEMVER.flatpak pro.kherel.selfprivacy"
}

package_linux_archive () {
  podman_online "/var/lib/builder/src" "tar -C build/linux/x64/release/bundle -vacf $APP_NAME-$APP_SEMVER.tar.zstd ."
}

while true; do
  case "$1" in
    --build-linux )
      build_linux
      shift
      ;;
    --build-apk )
      build_apk
      shift
      ;;
    --sign-apk-standalone )
      sign_apk_standalone
      shift
      ;;
    --sign-apk-fdroid )
      sign_apk_fdroid
      shift
      ;;
    --package-linux-appimage )
      package_linux_appimage
      shift
      ;;
    --package-linux-flatpak )
      package_linux_flatpak
      shift
      ;;
    --package-linux-archive )
      package_linux_archive
      shift
      ;;
    -- )
      shift
      break
      ;;
    *)
      usage
      ;;
  esac
done
