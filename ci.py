#!/usr/bin/env python3

import os
import subprocess
import yaml
import argparse

CONTAINER_IMAGE = "localhost/flutter-build-env"
HOST_HOME = "/var/lib/drone-runner-exec"
CONTAINER_HOME = "/var/lib/builder"

APP_NAME = "pro.kherel.selfprivacy"
APP_VERSION_FULL = yaml.safe_load(open("pubspec.yaml", "r"))['version']
APP_SEMVER = APP_VERSION_FULL[:APP_VERSION_FULL.find("+")]
APP_BUILD_ID = APP_VERSION_FULL[APP_VERSION_FULL.find("+"):][1::]

def podman_offline(dir, *args):
  subprocess.run(["podman", "run", "--rm", "--network=none", f"--workdir={dir}",
                  "-v", f"src:{CONTAINER_HOME}/src:U",
                  "-v", f"{HOST_HOME}/fdroid:{CONTAINER_HOME}/fdroid:U",
                  "-v", f"{HOST_HOME}/fdroid-keystore:{CONTAINER_HOME}/fdroid/fdroid-keystore:U",
                  "-v", f"{HOST_HOME}/standalone-keystore:{CONTAINER_HOME}/fdroid/standalone-keystore:U",
                  "--env", "FDROID_KEYSTORE_PASS=" + os.environ.get('FDROID_KEYSTORE_PASS'),
                  "--env", "STANDALONE_KEYSTORE_PASS=" + os.environ.get('STANDALONE_KEYSTORE_PASS'),
                  CONTAINER_IMAGE, "bash", "-c", ' '.join(args)
                 ])

def podman_online(dir, *args):
  subprocess.run(["podman", "run", "--rm", "--privileged", f"--workdir={dir}",
                  "-v", f"src:{CONTAINER_HOME}/src:U",
                  CONTAINER_IMAGE, "bash", "-c", ' '.join(args)
                 ])

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  group = parser.add_mutually_exclusive_group()
  group.add_argument("--build-linux", action="store_true")
  group.add_argument("--build-apk", action="store_true")
  group.add_argument("--sign-apk-standalone", action="store_true")
  group.add_argument("--sign-apk-fdroid", action="store_true")
  group.add_argument("--package-linux-appimage", action="store_true")
  group.add_argument("--package-linux-flatpak", action="store_true")
  group.add_argument("--package-linux-archive", action="store_true")
  args = parser.parse_args()

if args.build_linux:
  podman_offline(f"{CONTAINER_HOME}/src", "flutter pub get --offline")
  podman_offline(f"{CONTAINER_HOME}/src", "flutter build linux")
elif args.build_apk:
  podman_offline(f"{CONTAINER_HOME}/src", "flutter pub get --offline")
  podman_offline(f"{CONTAINER_HOME}/src", "flutter build apk")
elif args.sign_apk_standalone:
  podman_offline(f"{CONTAINER_HOME}/fdroid",
                 "zipalign -f -v 4 ../src/build/app/outputs/flutter-apk/app-release.apk",
                 f"standalone_{APP_NAME}-{APP_SEMVER}.apk")
  podman_offline(f"{CONTAINER_HOME}/fdroid",
                 "apksigner sign --ks standalone-keystore --ks-key-alias standalone --ks-pass",
                 f"env:STANDALONE_KEYSTORE_PASS standalone_{APP_NAME}-{APP_SEMVER}.apk")
elif args.sign_apk_fdroid:
  podman_offline(f"{CONTAINER_HOME}/fdroid", f"rm -rf {CONTAINER_HOME}/fdroid/unsigned/*")
  podman_offline(f"{CONTAINER_HOME}/fdroid",
                 f"test ! -f {CONTAINER_HOME}/fdroid/repo/{APP_NAME}_{APP_BUILD_ID}.apk",
                 "&& cp ../src/build/app/outputs/flutter-apk/app-release.apk",
                 f"unsigned/{APP_NAME}_{APP_BUILD_ID}.apk || echo exist")
  podman_offline(f"{CONTAINER_HOME}/fdroid", "fdroid publish")
  podman_offline(f"{CONTAINER_HOME}/fdroid", "fdroid update")
elif args.package_linux_appimage:
  podman_online(f"{CONTAINER_HOME}/src", "appimage-builder --recipe appimage.yml")
elif args.package_linux_flatpak:
  podman_online(f"{CONTAINER_HOME}/src", "flatpak-builder --disable-rofiles-fuse --force-clean --repo=flatpak-repo flatpak-build flatpak.yml")
  podman_online(f"{CONTAINER_HOME}/src", f"flatpak build-bundle flatpak-repo {APP_NAME}-{APP_SEMVER}.flatpak pro.kherel.selfprivacy")
elif args.package_linux_archive:
  podman_online(f"{CONTAINER_HOME}/src", f"tar -C build/linux/x64/release/bundle -vacf {APP_NAME}-{APP_SEMVER}.tar.zstd .")
