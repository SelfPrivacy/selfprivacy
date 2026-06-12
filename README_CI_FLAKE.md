# SelfPrivacy CI/CD/Releng Pipeline

## Summary Tables

### Builds

| Target           | Hermetic? | Offline? | Deterministic Buildenv? | Deterministic Output? | Distribution                     |
|------------------|-----------|----------|-------------------------|-----------------------|----------------------------------|
| Linux (nixpkgs)  | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | Nix                              |
| Linux (Generic)  | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | .tar.xz, AppImage, Flatpak, Snap |
| Linux (Portable) | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | .tar.xz, AppImage, .deb, .rpm    |
| Android          | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | .apk, .aab                       |
| macOS            | Yes ✅    | Yes ✅   | Yes ✅                  | No ❌                 | .app                             |
| iOS              | No ❌     | Yes ✅   | Maybe ❓                | No ❌                 | .ipa                             |
| Windows          | Maybe ❓  | Maybe ❓ | No ❌ [^3]              | No ❌                 | .zip, .msi                       |

[^3]: Everything except MSVC installer can be bootstrapped predictably

And Linux zoo separately:

| Target   | Hermetic? | Offline? | Deterministic Buildenv? | Deterministic Output? | Note                          |
|----------|-----------|----------|-------------------------|-----------------------|-------------------------------|
| Flatpak  | Yes ✅    | Yes ✅   | Yes ✅                  | No ❌ [^2]            | Packages Generic              |
| AppImage | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | Packages Generic and Portable |
| .tar.xz  | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | Packages Generic and Portable |
| Snap     |           |          |                         |                       | Packages Generic              |
| DEB      | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | Packages Portable             |
| RPM      | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | Packages Portable             |
| Pacman   | Yes ✅    | Yes ✅   | Yes ✅                  | Yes ✅                | Packages Portable             |

[^2]: Flatpak packages aren't reproducible and deterministic by default because they store metadata about how, when, and where the package was built, even though the rest of the ecosystem is reproducible.

### Nix Flake Commands

#### Packages

Use `nix build .#<name>` to build a package and `nix run .#<name>` if it supports running. Produces a `result` directory with a collectible artifact. If reproducible, can be ran with `--rebuild` flag.

| Name                    | Note                                                                                                                                               |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| default                 | Alias for linux-nix                                                                                                                                |
| linux-nix               | Package for nixpkgs. Runnable                                                                                                                      |
| linux-generic           | Redundant rebuild of linux-nix for packaging outside nixpkgs. See next section for explanation                                                     |
| linux-portable          | Standalone target based on AlmaLinux 8, Conda Forge, Pixi, and Bubblewrap to link against glibc 2.28. We use Nix only for a controlled environment |
| linux-flatpak           |                                                                                                                                                    |
| linux-appimage-generic  |                                                                                                                                                    |
| linux-appimage-portable |                                                                                                                                                    |
| linux-archive-generic   |                                                                                                                                                    |
| linux-archive-portable  |                                                                                                                                                    |
| android-\$1-\$2-\$3     | Cartesian product of {apk,aab}-{release,debug}{production,fdroid,nightly}                                                                          |
| macos                   |                                                                                                                                                    |

And dependencies:

| Name                    | Note                                                                                                                                        |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| flutter-deps            | Downloads Flutter dependencies in a `$PUB_CACHE`-compatible directory, can be used on all platforms                                           |
| linux-flatpak-sdk       | Downloads Freedesktop Runtime and SDK, and creates an ostree-compatible repository                                                          |
| linux-buildroot         | Combination of linux-buildroot-deps, linux-buildroot-toolkit, and Flutter                                                                   |
| linux-buildroot-deps    | Ad-hoc nano-distribution from AlmaLinux 8 packages, extracted to form a rootfs for Bubblewrap                                               |
| linux-buildroot-toolkit | Reproducible Conda Forge distribution downloaded using Pixi lockfile, provides the actual development environment for our nano-distribution |
| android-gradle-deps     | Hundreds of Nix derivations generated by [gradle2nix](https://github.com/tadfisher/gradle2nix/tree/v2) needed for building Android releases |
| macos-cocoa-deps        | CocoaPods dependencies for macOS target                                                                                                     |
| ios-cocoa-deps          | CocoaPods dependencies for iOS. Apparently incompatible with the macOS target                                                                          |

#### Runnables

Duplicates the build environments above and adds new commands that are ran in current shell session, rather than Nix sandbox.

Use as `nix run .#<name>`.

| Name            | Note |
|-----------------|------|
| test-flutter    |      |
| analyze-flutter |      |
| scan-sonarqube  |      |
| sign-android    |      |
| deploy-android  |      |
| sign-macos      |      |
| deploy-macos    |      |
| build-ios       |      |
| sign-ios        |      |
| deploy-ios      |      |

#### Shells

Use as `nix develop -i .#<name>`.

| Name              | Note |
|-------------------|------|
| test              |      |
| analyze           |      |
| scan              |      |
| sign              |      |
| fdroid            |      |
| linux             |      |
| linux-flatpak     |      |
| linux-appimage    |      |
| android           |      |
| macos             |      |
| ios               |      |

## Chores

### Using Android Keystores in CI

Create these secrets: `CI_KEYSTORE_FILE_GOOGLE`, `CI_KEYSTORE_FILE_FDROID`, `CI_KEYSTORE_FILE_NIGHTLY`. You need to convert your corresponding keystores into text using `base64 -w 0 yourkeystore.jks`. To decode it in CI, use e.g. `echo $CI_KEYSTORE_FILE_GOOGLE | base64 -d > google-keystore.jks`.

They need the corresponding password secrets: `CI_KEYSTORE_PASS_GOOGLE`, `CI_KEYSTORE_PASS_FDROID`, `CI_KEYSTORE_PASS_NIGHTLY`.

You need to set `$CI_KEYSTORE_FILE` and `$CI_KEYSTORE_PASS` environment variables, where `$CI_KEYSTORE_FILE` is a path relative to the root of the source code or a full path.

### Updating Buildroot Packages

This is not automated, because there is no proper way to perform dependency resolution for RHEL packages without a RHEL distribution. We need exactly three programs from it: glibc, bash, and busybox — six packages in total if we count additional transitory ones. We extract them by hand and don't care about correctness, we only need to form a pseudo-rootfs.

Unless there are security implications, we don't need to bump their version. But if we should, look for package names at the corresponding URLs in `flake-parts/packages/linux-buildroot.nix`.

### Updating Buildroot Pixi Lockfile

Pixi lockfile and workspace file are located in `ci/` directory. You can check for new package versions at <https://anaconda.org/channels/conda-forge> and bump them in the TOML file.

To update the lockfile, use `pixi update`. To install the environment without updating the lockfile, use `pixi install --frozen`. To enter development environment, use `pixi shell`. To just inherit needed environment variables, use `source <(pixi shell-hook)`. To reliably use Pixi offline, it needs actual packed binary Rattler cache, so when calling it offline, use something like `export PIXI_CACHE_DIR=$BUILDENV/rattler/cache`. For the reproducible CI purposes, we use [pixi-pack](https://github.com/Quantco/pixi-pack)/pixi-unpack instead of the regular Pixi because Rattler cache isn't offline-friendly. 

### Updating Flatpak SDK/Runtime Commit

You need Flatpak and OSTree utilities installed, and Flathub repository added.

Find the latest Freedesktop SDK and Runtime versions available (e.g., 25.08):

```
sudo ostree remote refs --repo /var/lib/flatpak/repo flathub | grep freedesktop
```

Get the latest commits of both:

```
sudo ostree log --repo /var/lib/flatpak/repo flathub:runtime/org.freedesktop.Sdk/x86_64/25.08
sudo ostree log --repo /var/lib/flatpak/repo flathub:runtime/org.freedesktop.Platform/x86_64/25.08
```

Write down these commits in `flake-parts/packages/linux-flatpak-sdk.nix` and bump its' Nix SRI hash.

### Updating Android Gradle Lockfile

gradle2nix outputs a lock file that should be fed to the `gradle2nix.buildMavenRepo` function. To make a correct lockfile, gradle2nix needs to perform a full build of all needed targets, for this we have a special Gradle task: you need to launch it as `gradle2nix -p android/ -t assembleProductionAll` inside, say, `nix develop -i .#android` shell. The `assembleProductionAll` definition is located in `android/app/build.gradle` file. To actually build anything offline, use `gradle --no-daemon --offline -I offline.gradle <taskname>`.

gradle2nix lockfile is located in `android/` directory.

### Updating Flutter and macOS/iOS CocoaPods Deps

After each `pubspec.lock` and `Podfile.lock` change, just rerun needed commands:

```
nix build .#flutter-deps
nix build .#macos-cocoa-deps
nix build .#ios-cocoa-deps
```

And write down new SRI hashes in `flake-parts/packages/{flutter,macos-cocoa,ios-cocoa}-deps.nix` if needed

### To Do

- [X] Nix-native dependency resolver for Pub in non-nixpkgs builds
- [ ] Nix-native dependency resolver for CocoaPods
- [X] Nix-native dependency resolver for Conda/Pixi/Rattler
  - Implementation is available in `flake-parts/misc/create-conda-repo.nix`
  - Superseded by using [pixi-pack](https://github.com/Quantco/pixi-pack)/pixi-unpack
  - We don't use the Nix implementation because Pixi is hostile to offline environments
  - [ ] Use directory unpacker when it'll be implemented https://github.com/Quantco/pixi-pack/issues/245

## Technical Decisions

### flake-parts

This project uses modular flake-parts that gives handy abstractions to make derivations OS-agnostic. Everything is stored in the `flake-parts/` directory and beautifully decoupled into subdirectories with separate files.

We use some sort of a global namespace called `sp` to reuse frequently called functions, variable, or packages.

It's defined as `_module.args.sp {}`. Maybe we should use the `config.` args? 

https://flake.parts/module-arguments
https://nixos.wiki/wiki/NixOS_modules

### lndir Pattern

Many programs that we run want to write in files that we store in R/O Nix store (say, Flutter in `$PUB_CACHE`, CocoaPods in `$GEM_HOME` etc.). To bypass this, we are inventing a poor man's overlayfs: lndir recreates some directory's structure from Nix store recursively, creating real writable directories and filling them with symlinks to R/O files. It's enough to satisfy most of the programs, but eventually it's better to move into more idiomatic Nix implementations.

### find -exec rm {} + Pattern

Until we adopt the idiomatic Nix way to cache dependencies, in the meantime we just ad-hoc A/B test two resulting directories and delete diverging files. Ugly.

### Linux Generic Target

It's greatly more preferable to just copy binaries from Nix store and patch their rpath using `patchelf`, but for not obvious reasons the resulting binary can't render graphics on non-Nix systems, even though their rpath doesn't mention Nix store at all. Because of this, we build the generic artifact separately, in the same Nix store, but without Nix-specific wrapping. For some reason, this works, and copying the nixpkgs version doesn't.

### Why Not Use Nix for Flatpak and AppImage?

The same obstacle as before, the resulting binaries can't render graphics. Strange!

This needs investigation how to make NixGL reliably working.

### Linux Portable Target

Linux Generic target links against its' current glibc version. For instance, nixpkgs 25.11 builds everything against glibc 2.40, which is bleeding edge in libc terms (released in 2024). This build won't work on many LTS distributions, but is enough for Flatpak and Snap packaging, both bundling a relatively new glibc version. But for AppImages and regular archive files, this is useless, considering the majority of users will be using distributions like Ubuntu 22.04 (glibc 2.35), Ubuntu 24.04 (glibc 2.39), Debian 11 (glibc 2.31), Debian 12 (glibc 2.36) etc.

Linking anything against an old glibc version is an infamously cumbersome process. Best case scenario, you have a controlled C/C++ environment and can, say, use Zig compiler that does it for you. But in our case with Flutter, our best bet is using the oldest possible LTS Linux distribution that can run Flutter compiler. There is a possibility to use RHEL 7/Ubuntu 14.04/Debian 8 era distributions, but it's too extreme and there is no public support for them. We settle on RHEL 8 (glibc 2.28) as a reasonable middle ground: everything older than RHEL 8 should use Flatpak or Snap any way.

We only need glibc from RHEL 8, nothing more. Maybe also Busybox and Bash to be able to launch programs. We can't use the actual RHEL 8 compiler infrastructure, gathering everything declaratively and reproducibly is hard and fragile. But hear some good news: we have a standalone infrastructure that builds reproducible and declarative dependencies against an old glibc version, it's Conda Forge! And we have a very handy Conda package manager in one static Rust binary, [Pixi](https://pixi.prefix.dev/). This little utility constructs a reproducible build environment from a lock file and allows to simply put everything needed in our's nano-distribution `$PATH` — and it just works. We (ab)use Nix store to automate this process, and use Bubblewrap to trick the build environment into thinking that RHEL 8's glibc is the system's glibc.

Another alternative is using OCI contaiters and we don't want that.

### Flatpak

Just like [nix2flatpak](https://github.com/neobrain/nix2flatpak), we download a whole ass Flatpak SDK (actually, *two of them*) and store it as an offline-enabled ostree repository, just to be able to package a prebuilt binary with no dependencies. It's meaningless, but it seems there is no other way. And contrary to a popular belief, Flathub doesn't punish you for publishing prebuilt binaries, it's genuinely hard to build Flutter projects in Flatpak environment.

### AppImage

There are many ways to create AppImages, but we use the simplest one: [appimagetool](https://github.com/AppImage/appimagetool) with [type2-runtime](https://github.com/AppImage/type2-runtime). We create an AppDir, populate it with a binary, manually picked libraries, an icon, a desktop and an AppStream files. There are options that try to automate this, like [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy), but in our case they do more harm than benefit.

### Android

Trying to cache hundreds of Gradle dependencies seems to be an impossible task, considering `$GRADLE_USER_HOME` is ever-mutable and unstable target. The only way out of it is building your own Maven-compatible local repository. What [gradle2nix](https://github.com/tadfisher/gradle2nix/tree/v2) is exactly doing, creating a derivation combining hundreds of other derivations that are Gradle packages.

### macOS & iOS

To actually build anything, we are forced to put some predefined version of Xcode in Nix store. Building with Nix's clang seems to be not possible, thus distributing Flutter applications using nixpkgs isn't a realistic option.

Flutter CLI for macOS and iOS differs, so if we were able to successfully launch macOS builds in Nix sandbox, this isn't the case for iOS, even though the actual `xcodebuild` CLI under the hood is the same. It should be possible to build iOS in the Nix sandbox, but it's not at the moment.

Some vital options to make it run in Nix sandbox:

```
export XDG_CONFIG_HOME="$HOME/.config"

export LANG="en_US.UTF-8"

# Build without signing (thus, without relying on /usr/bin/codesign)
cat >> macos/Runner/Configs/Release.xcconfig << EOF
CODE_SIGNING_ALLOWED=NO
CODE_SIGNING_REQUIRED=NO
CODE_SIGN_IDENTITY=
AD_HOC_CODE_SIGNING_ALLOWED=NO
EOF
```

To bypass the Flutter's quirk in copying files from Nix store, we substitute the `lipo` binary to make it run `chmod -R +w` during the build process. See the `ci/darwin/` files for that.

### Windows

It's virtually impossible to get a reproducible build environment with Windows, so we are doing our best here. We use native Windows Containers for isolation and at least some sort of predictable environment. Our container is tested against both Docker runtime and more manual containerd/buildkitd/nerdctl stack, though the Docker runtime is significantly faster and more stable for some reason. To download dependencies, we rely on Chocolatey.

In a better world we would be able to use Windows Server 2025 Nano image that is only 300 megabytes worth, but it lacks needed runtime frameworks and utilities to launch anything. Instead we use 2 gigabytes of Windows Server 2025 Core image. By default, everything is ran as Administrator, and there is no simple way to make an unprivileged containere usable. Moreover, mounting files inherits host's permissions, so unprivileged users can't write nor read to them.

To surpass this, we researched a lot of ways to drop privileges. By default, regular users can't create symlinks, and symlinks are needed for Flutter to build projects. We patch the system's privileges file to allow symlinks for Users. And to workaround the mounted files limitation, we are using Windows scheduled task as a sudo replacement for executing predefined commands (changing permissions of the mounted files in our case). Again, regular users have no permissions for executing scheduled tasks, so we update their privileges using COM calls. In the end, we have a relatively unprivileged container that can do only what is defined.
