# SelfPrivacy App

SelfPrivacy is an app that helps you to deploy and manage private services.

#### Table of Contents

- [What is SelfPrivacy app](#what-is-selfprivacy-app)
- [Building](#building)
- [Translation](#translation)

## What is SelfPrivacy app

SelfPrivacy is a cross-platform app that allows you to set up self-hosted services and manage them.

### Setup guide

[A more complete setup guide is available on our website!](https://selfprivacy.org/docs/getting-started/)

### How does it work?

You need to copy hosting and DNS providers' access tokens to the app.
App will give a few choices on how to configure the server.

App will:

- Set up NixOS operating system
- Create DNS records
- Add SSL certificates
- Create backups on third party services
- Install services you choose such as email, cloud etc.

After installation you can manage your server, users and services directly from the app, without interacting with the terminal.

Services available out of the box:

* [Email](https://selfprivacy.org/docs/services/email/)
* [DeltaChat](https://selfprivacy.org/docs/services/delta-chat/)
* [NextCloud](https://selfprivacy.org/docs/services/nextcloud/)
* [Jitsi](https://selfprivacy.org/docs/services/jitsi/)
* [Gitea](https://selfprivacy.org/docs/services/gitea/)
* [Bitwarden](https://selfprivacy.org/docs/services/bitwarden/)
* Mumble

If a service you need is not listed, you can add it yourself using [SelfPrivacy modules](https://selfprivacy.org/docs/theory/selfprivacy_modules/).

## Building

Supported platforms are Android, Linux, and Windows. We are looking forward to support iOS and macOS builds.

### For Linux builds, make sure you have these packages installed

#### Arch

```
pacman -S ninja xdg-user-dirs gnome-keyring unzip xz-utils zip
```

#### Debian

```
apt install ninja-build xdg-user-dirs gnome-keyring unzip xz-utils zip
```

Install [Flutter](https://docs.flutter.dev/get-started/install/linux) and [Android SDK tools](https://developer.android.com/studio/command-line/sdkmanager), then try your setup:

```
flutter pub get
```

### Build for Android

#### Build .apk

```
flutter build apk --flavor production
```

#### Build nightly .apk

```
flutter build apk --flavor nightly
```

#### Build AAB bundle for Google Play

```
flutter build aab --flavor production
```

### Build Linux binaries

```
flutter build linux
```

### Build Windows binaries

```
flutter build windows
```

### Packaging

#### AppImage

```
appimage-builder --recipe appimage.yml
```

#### Flatpak

```
flatpak-builder --force-clean --repo=flatpak-repo flatpak-build flatpak.yml
flatpak build-bundle flatpak-repo org.selfprivacy.app.flatpak org.selfprivacy.app
```

## Translation

[![Translation status](http://weblate.selfprivacy.org/widgets/selfprivacy/-/selfprivacy-app/multi-auto.svg)](http://weblate.selfprivacy.org/engage/selfprivacy/)

Translations are stored in `assets/translations/*.json` and can be edited on <https://weblate.selfprivacy.org/projects/selfprivacy/selfprivacy-app/>.
