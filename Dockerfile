FROM ubuntu:22.04

ENV PACKAGES "build-essential openjdk-11-jdk-headless clang cmake curl git jq libblkid1 libblkid-dev libc6 libc6-dev libc-bin libcrypt1 libdbus-1-3 libexpat1 libffi7 libgcc-s1 libgcrypt20 libgcrypt20-dev libglib2.0-0 libglib2.0-dev libglu1-mesa libgpg-error0 libgtk-3-0 libgtk-3-dev liblz4-1 liblz4-dev liblzma5 liblzma-dev libmount1 libpcre3 libselinux1 libsepol2 libstdc++-10-dev libstdc++6 libuuid1 ninja-build pkg-config rsync unzip xz-utils zlib1g unzip libsecret-1-dev libsecret-tools libsecret-1-0 libjsoncpp-dev fuse flatpak-builder binutils coreutils desktop-file-utils fakeroot fuse libgdk-pixbuf2.0-dev patchelf python3-pip python3-setuptools squashfs-tools strace util-linux zsync"
ENV ANDROID_SDK_TOOLS_VERSION "commandlinetools-linux-8512546_latest"
ENV ANDROID_SDK_TOOLS_URL "https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip"
ENV FLUTTER_VERSION "flutter_linux_3.3.1-stable"
ENV FLUTTER_URL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.3.1-stable.tar.xz"
ENV FREEDESKTOP_SDK_VERSION "22.08"

# Update packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y $PACKAGES

# Add a non-privileged user
RUN useradd -d /var/lib/builder -m -r -s /bin/bash builder
USER builder
WORKDIR /var/lib/builder

# Install Android SDK
ADD --chown=builder $ANDROID_SDK_TOOLS_URL .
RUN mkdir -p android-sdk/cmdline-tools && unzip $ANDROID_SDK_TOOLS_VERSION.zip \
    && rm $ANDROID_SDK_TOOLS_VERSION.zip && mv cmdline-tools android-sdk/cmdline-tools/latest

# Install Flutter
ADD --chown=builder $FLUTTER_URL .
RUN tar -vxf $FLUTTER_VERSION.tar.xz && rm $FLUTTER_VERSION.tar.xz

ENV ANDROID_HOME "/var/lib/builder/android-sdk"
ENV ANDROID_SDK_ROOT "/var/lib/builder/android-sdk"
ENV PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:/var/lib/builder/flutter/bin:/var/lib/builder/.local/bin"

# Install needed Android SDK packages
RUN yes | sdkmanager 'build-tools;30.0.3' 'platforms;android-29' 'platforms;android-30' 'platforms;android-31'

# Prepare dependencies for offline build
RUN git clone --depth=1 --single-branch https://git.selfprivacy.org/kherel/selfprivacy.org.app.git deps
WORKDIR /var/lib/builder/deps
RUN flutter build linux
RUN flutter build apk
WORKDIR /var/lib/builder
RUN rm -rf deps

# Install AppImage Builder
RUN pip3 install --user appimage-builder

# Install Flatpak dependencies
RUN flatpak --user remote-add flathub https://flathub.org/repo/flathub.flatpakrepo \
    && flatpak --user install -y org.freedesktop.Sdk/x86_64/$FREEDESKTOP_SDK_VERSION \
                                 org.freedesktop.Platform/x86_64/$FREEDESKTOP_SDK_VERSION
