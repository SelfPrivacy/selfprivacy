# SelfPrivacy App

SelfPrivacy is an app for deploying and managing private self-hosted services.

- [Get it on Google Play](https://play.google.com/store/apps/details?id=org.selfprivacy.app&pli=1)
- [Get it on F-Droid](https://f-droid.org/en/packages/pro.kherel.selfprivacy/)

## Table of Contents
- [How it works](#how-it-works)
- [Setup guide](#setup-guide)
- [Building](#building)
- [Packaging](#packaging)
- [Translation status](#translation-status)

## How it works
Usually you would configure your server and services manually in multiple different places. With this app, you can now manage everything from one simple interface.
SelfPrivacy automates interaction between hosting and DNS providers using [SelfPrivacy API](https://git.selfprivacy.org/SelfPrivacy/selfprivacy-rest-api).

## Setup guide
[The setup guide is available on our website!](https://selfprivacy.org/docs/getting-started/)

After the setup, you will have a NixOS operating system installed on your server. Through the app you will create DNS records, obtain SSL certificates and install the services you need.

### Services available out of the box:
* [Email](https://selfprivacy.org/docs/services/email/)
* [DeltaChat](https://selfprivacy.org/docs/services/delta-chat/)
* [NextCloud](https://selfprivacy.org/docs/services/nextcloud/)
* [Jitsi](https://selfprivacy.org/docs/services/jitsi/)
* [Gitea](https://selfprivacy.org/docs/services/gitea/)
* [Bitwarden](https://selfprivacy.org/docs/services/bitwarden/)
* [Mumble](https://forum.selfprivacy.org/t/mumble-murmur/88)

If a service you need is not listed, you can add it yourself using [SelfPrivacy modules](https://selfprivacy.org/docs/theory/selfprivacy_modules/).

## Building

Supported platforms are Android, Linux, and Windows. We are looking forward to support iOS and macOS builds.

### 1. Install [Flutter](https://docs.flutter.dev/get-started/install)
### 2. Install [Android SDK tools](https://developer.android.com/studio/command-line/sdkmanager)
### 3. Install dependencies
#### Arch
```sh
pacman -S ninja xdg-user-dirs gnome-keyring unzip xz-utils zip
```

#### Debian
```sh
apt install ninja-build xdg-user-dirs gnome-keyring unzip xz-utils zip
```

### 4. Clone the repo
```sh
git clone https://git.selfprivacy.org/SelfPrivacy/selfprivacy.org.app.git
```

### 5. Try your setup:
```sh
flutter pub get
```

---

### Building for Android


#### Build .apk

```sh
flutter build apk --flavor production
```

#### Build nightly .apk

```sh
flutter build apk --flavor nightly
```

#### Build AAB bundle for Google Play

```sh
flutter build aab --flavor production
```

### Building Linux binaries

```sh
flutter build linux
```

### Building Windows binaries

```sh
flutter build windows
```

## Packaging

### AppImage

```sh
appimage-builder --recipe appimage.yml
```

### Flatpak

```sh
flatpak-builder --force-clean --repo=flatpak-repo flatpak-build flatpak.yml
flatpak build-bundle flatpak-repo org.selfprivacy.app.flatpak org.selfprivacy.app
```

## Translation status

[![Translation status](http://weblate.selfprivacy.org/widgets/selfprivacy/-/selfprivacy-app/multi-auto.svg)](http://weblate.selfprivacy.org/engage/selfprivacy/)

Translations are stored in `assets/translations/*.json` and can be edited on <https://weblate.selfprivacy.org/projects/selfprivacy/selfprivacy-app/>.