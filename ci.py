#!/usr/bin/env python3

import os
import subprocess
import requests
import yaml
import argparse

CONTAINER_IMAGE = "registry.selfprivacy.org:5001/flutter-build-env"
HOST_HOME = "/var/lib/drone-runner-exec"
CONTAINER_HOME = "/tmp/builder"
HOST_MOUNTED_VOLUME = f"{HOST_HOME}/.local/share/containers/storage/volumes/release/_data"

APP_NAME = "org.selfprivacy.app"
APP_NAME_NIGHTLY = "org.selfprivacy.app.nightly"
APP_VERSION_FULL = yaml.safe_load(open("pubspec.yaml", "r"))['version']
APP_SEMVER = APP_VERSION_FULL[:APP_VERSION_FULL.find("+")]
APP_BUILD_ID = APP_VERSION_FULL[APP_VERSION_FULL.find("+"):][1::]
APP_BUILD_ID_NIGHTLY = subprocess.run(["git", "rev-list", "--first-parent", "--count", "HEAD"], check=True, stdout=subprocess.PIPE).stdout.decode().strip()

GITEA_HOST_URL = "https://git.selfprivacy.org"
GITEA_REPO_FULL = os.environ.get("DRONE_REPO") or "kherel/selfprivacy.org.app"
GITEA_REPO_OWNER = os.environ.get("DRONE_REPO_OWNER") or "kherel"
GITEA_REPO_NAME = os.environ.get("DRONE_REPO_NAME") or "selfprivacy.org.app"

# Environments

def podman_offline(dir, *args):
  subprocess.run(["podman", "run", "--rm", "--network=none", "--cap-add=CHOWN", f"--workdir={dir}",
                  "-v", os.getcwd() + f":{CONTAINER_HOME}/src",
                  "-v", f"{HOST_HOME}/fdroid:{CONTAINER_HOME}/fdroid",
                  "-v", f"{HOST_HOME}/fdroid-keystore:{CONTAINER_HOME}/fdroid-keystore",
                  "-v", f"{HOST_HOME}/standalone-keystore:{CONTAINER_HOME}/standalone-keystore",
                  "-v", f"{HOST_HOME}/google-keystore:{CONTAINER_HOME}/google-keystore",
                  "--env", "FDROID_KEYSTORE_PASS=" + os.environ.get("FDROID_KEYSTORE_PASS"),
                  "--env", "STANDALONE_KEYSTORE_PASS=" + os.environ.get("STANDALONE_KEYSTORE_PASS"),
                  "--env", "GOOGLE_KEYSTORE_PASS=" + os.environ.get("GOOGLE_KEYSTORE_PASS"),
                  "--user", os.getuid().__str__() + ":" + os.getgid().__str__(), "--userns=keep-id",
                  "--ulimit", "nofile=102400:102400", CONTAINER_IMAGE, "bash", "-c", ' '.join(args)
                 ], check=True)

def podman_online(dir, *args):
  subprocess.run(["podman", "run", "--rm", "--cap-add=CHOWN", f"--workdir={dir}",
                  "-v", os.getcwd() + f":{CONTAINER_HOME}/src",
                  "--user", os.getuid().__str__() + ":" + os.getgid().__str__(), "--userns=keep-id",
                  "--ulimit", "nofile=102400:102400",CONTAINER_IMAGE, "bash", "-c", ' '.join(args)
                 ], check=True)

# Utilities

def gitea_create_release():
  url = f"{GITEA_HOST_URL}/api/v1/repos/{GITEA_REPO_FULL}/releases"
  token = os.environ.get("GITEA_RELEASE_TOKEN")
  params = {"access_token": f"{token}"}
  json = {"tag_name": f"{os.environ.get('DRONE_SEMVER') or APP_SEMVER}", "name": f"{os.environ.get('DRONE_SEMVER' or APP_SEMVER)}", "prerelease": True}

  request = requests.post(url, params=params, json=json)

  try:
    request.raise_for_status()
  except requests.exceptions.HTTPError as error:
    print(error)
    return error

def gitea_get_release_id():
  url = f"{GITEA_HOST_URL}/api/v1/repos/{GITEA_REPO_FULL}/releases/tags/{os.environ.get('DRONE_SEMVER') or APP_SEMVER}"

  request = requests.get(url)

  try:
    request.raise_for_status()
  except requests.exceptions.HTTPError as error:
    print(error)
    return error

  return request.json()['id']

def gitea_upload_attachment(file):
  id = gitea_get_release_id()
  url = f"{GITEA_HOST_URL}/api/v1/repos/{GITEA_REPO_FULL}/releases/{id}/assets"
  token = os.environ.get("GITEA_RELEASE_TOKEN")
  params = {"access_token": f"{token}", "name": f"{os.path.basename(file)}"}
  files = {"attachment": open(f"{file}", "br")}

  request = requests.post(url, params=params, files=files)

  try:
    request.raise_for_status()
  except requests.exceptions.HTTPError as error:
    print(error)
    return error

# Targets

def build_linux():
  podman_online(f"{CONTAINER_HOME}/src", "chown -R $(id -u):$(id -g) /tmp/flutter_pub_cache",
                                          "&& flutter pub get --offline",
                                          "&& flutter build linux")

def build_apk():
  podman_online(f"{CONTAINER_HOME}/src", "chown -R $(id -u):$(id -g) /tmp/gradle /tmp/flutter_pub_cache",
                                          "&& flutter pub get",
                                          "&& flutter build apk --flavor production")
def build_bundle():
  podman_online(f"{CONTAINER_HOME}/src", "chown -R $(id -u):$(id -g) /tmp/gradle /tmp/flutter_pub_cache",
                                          "&& flutter pub get",
                                          "&& flutter build appbundle --flavor production")

def sign_apk_standalone():
  podman_offline(f"{CONTAINER_HOME}/src",
                 "zipalign -f -v 4 build/app/outputs/flutter-apk/app-production-release.apk",
                 f"standalone_{APP_NAME}-{APP_SEMVER}.apk")
  podman_offline(f"{CONTAINER_HOME}/src",
                 f"apksigner sign --ks {CONTAINER_HOME}/standalone-keystore --ks-key-alias standalone --ks-pass",
                 f"env:STANDALONE_KEYSTORE_PASS standalone_{APP_NAME}-{APP_SEMVER}.apk")

def sign_apk_fdroid():
  podman_offline(f"{CONTAINER_HOME}/fdroid", f"rm -rf {CONTAINER_HOME}/fdroid/unsigned/*")
  podman_offline(f"{CONTAINER_HOME}/fdroid",
                 f"test ! -f {CONTAINER_HOME}/fdroid/repo/{APP_NAME}_{APP_BUILD_ID}.apk",
                 "&& cp ../src/build/app/outputs/flutter-apk/app-production-release.apk",
                 f"unsigned/{APP_NAME}_{APP_BUILD_ID}.apk || echo exist")
  podman_offline(f"{CONTAINER_HOME}/fdroid", "fdroid publish")
  podman_offline(f"{CONTAINER_HOME}/fdroid", "fdroid update")

def sign_apk_fdroid_nightly():
  podman_offline(f"{CONTAINER_HOME}/fdroid", f"rm -rf {CONTAINER_HOME}/fdroid/unsigned/*")
  podman_offline(f"{CONTAINER_HOME}/fdroid",
                 f"test ! -f {CONTAINER_HOME}/fdroid/repo/{APP_NAME_NIGHTLY}_{APP_BUILD_ID_NIGHTLY}.apk",
                 "&& cp ../src/build/app/outputs/flutter-apk/app-nightly-release.apk",
                 f"unsigned/{APP_NAME_NIGHTLY}_{APP_BUILD_ID_NIGHTLY}.apk || echo exist")
  podman_offline(f"{CONTAINER_HOME}/fdroid", "fdroid publish")
  podman_offline(f"{CONTAINER_HOME}/fdroid", "fdroid update")

def sign_bundle():
  podman_offline(f"{CONTAINER_HOME}/src",
                 f"jarsigner -sigalg SHA256withRSA -digestalg SHA-256 -keystore {CONTAINER_HOME}/google-keystore -signedjar {APP_NAME}-{APP_SEMVER}.aab -storepass:env GOOGLE_KEYSTORE_PASS build/app/outputs/bundle/productionRelease/app-production-release.aab google")

def package_linux_appimage():
  podman_online(f"{CONTAINER_HOME}/src", "appimage-builder --recipe appimage.yml")

def package_linux_flatpak():
  subprocess.run(["flatpak-builder", "--force-clean", "--repo=flatpak-repo", "flatpak-build", "flatpak.yml"], check=True)
  subprocess.run(["flatpak", "build-bundle", "flatpak-repo", f"{APP_NAME}-{APP_SEMVER}.flatpak", f"{APP_NAME}"], check=True)

def package_linux_archive():
  podman_online(f"{CONTAINER_HOME}/src", f"tar -C build/linux/x64/release/bundle -vacf {APP_NAME}-{APP_SEMVER}.tar.zstd .")

def deploy_gitea_release():
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/standalone_{APP_NAME}-{APP_SEMVER}.apk")
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/standalone_{APP_NAME}-{APP_SEMVER}.apk.idsig")
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/{APP_NAME}-{APP_SEMVER}.aab")
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/SelfPrivacy-{APP_SEMVER}-x86_64.AppImage")
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/SelfPrivacy-{APP_SEMVER}-x86_64.AppImage.zsync")
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/{APP_NAME}-{APP_SEMVER}.flatpak")
  gitea_upload_attachment(f"{HOST_MOUNTED_VOLUME}/{APP_NAME}-{APP_SEMVER}.tar.zstd")

def package_windows_archive():
  import shutil
  shutil.make_archive(f"selfprivacy-{APP_SEMVER}-win32", 'zip', "build/windows/runner/Release")

def deploy_windows_archive():
  gitea_upload_attachment(f"selfprivacy-{APP_SEMVER}-win32.zip")

def deploy_fdroid_repo():
  subprocess.run([f"""eval $(ssh-agent -s) &&
                      echo \"$SSH_PRIVATE_KEY\" | tr -d '\r' | ssh-add - &&
                      scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -r {HOST_HOME}/fdroid/repo/* deployer@selfprivacy.org:/var/www/fdroid.selfprivacy.org
                  """], shell=True, check=True)

def ci_build_linux():
  podman_online(f"{CONTAINER_HOME}/src", "chown -R $(id -u):$(id -g) /tmp/flutter_pub_cache",
                                         "&& flutter pub get",
                                         "&& flutter build linux --debug")

def ci_build_apk():
  podman_online(f"{CONTAINER_HOME}/src", "chown -R $(id -u):$(id -g) /tmp/gradle /tmp/flutter_pub_cache",
                                         "&& flutter pub get",
                                         "&& flutter build apk --flavor nightly")

def ci_run_tests():
  podman_online(f"{CONTAINER_HOME}/src", "chown -R $(id -u):$(id -g) /tmp/gradle /tmp/flutter_pub_cache",
                                         "&& flutter test",
                                         "&& flutter test --machine --coverage > tests.output")

# Arguments

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  group = parser.add_mutually_exclusive_group()
  group.add_argument("--build-linux", action="store_true")
  group.add_argument("--build-apk", action="store_true")
  group.add_argument("--build-bundle", action="store_true")
  group.add_argument("--sign-apk-standalone", action="store_true", help="depends on $STANDALONE_KEYSTORE_PASS")
  group.add_argument("--sign-apk-fdroid", action="store_true", help="depends on $FDROID_KEYSTORE_PASS")
  group.add_argument("--sign-apk-fdroid-nightly", action="store_true", help="depends on $FDROID_KEYSTORE_PASS")
  group.add_argument("--sign-bundle", action="store_true", help="depends on $GOOGLE_KEYSTORE_PASS")
  group.add_argument("--package-linux-appimage", action="store_true")
  group.add_argument("--package-linux-flatpak", action="store_true")
  group.add_argument("--package-linux-archive", action="store_true")
  group.add_argument("--package-windows-archive", action="store_true")
  group.add_argument("--deploy-gitea-release", action="store_true", help="depends on $GITEA_RELEASE_TOKEN")
  group.add_argument("--deploy-fdroid-repo", action="store_true", help="depends on $SSH_PRIVATE_KEY")
  group.add_argument("--deploy-windows-archive", action="store_true")
  group.add_argument("--ci-build-linux", action="store_true")
  group.add_argument("--ci-build-apk", action="store_true")
  group.add_argument("--ci-run-tests", action="store_true")
  group.add_argument("--gitea-create-release", action="store_true")
  group.add_argument("--gitea-upload-attachment", action="store")
  args = parser.parse_args()

if args.build_linux:
  build_linux()
elif args.build_apk:
  build_apk()
elif args.build_bundle:
  build_bundle()
elif args.sign_apk_standalone:
  sign_apk_standalone()
elif args.sign_apk_fdroid:
  sign_apk_fdroid()
elif args.sign_apk_fdroid_nightly:
  sign_apk_fdroid_nightly()
elif args.sign_bundle:
  sign_bundle()
elif args.package_linux_appimage:
  package_linux_appimage()
elif args.package_linux_flatpak:
  package_linux_flatpak()
elif args.package_linux_archive:
  package_linux_archive()
elif args.package_windows_archive:
  package_windows_archive()
elif args.deploy_gitea_release:
  deploy_gitea_release()
elif args.deploy_fdroid_repo:
  deploy_fdroid_repo()
elif args.deploy_windows_archive:
  deploy_windows_archive()
elif args.ci_build_linux:
  ci_build_linux()
elif args.ci_build_apk:
  ci_build_apk()
elif args.ci_run_tests:
  ci_run_tests()
elif args.gitea_create_release:
  gitea_create_release()
elif args.gitea_upload_attachment:
  gitea_upload_attachment(args.gitea_upload_attachment)

