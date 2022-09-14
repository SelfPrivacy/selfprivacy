FROM ubuntu:22.04

ARG PACKAGES="build-essential openjdk-11-jdk-headless clang cmake curl git jq libblkid1 \
              libblkid-dev libc6 libc6-dev libc-bin libcrypt1 libdbus-1-3 libexpat1 libffi7 \
              libgcc-s1 libgcrypt20 libgcrypt20-dev libglib2.0-0 libglib2.0-dev libglu1-mesa \
              libgpg-error0 libgtk-3-0 libgtk-3-dev liblz4-1 liblz4-dev liblzma5 liblzma-dev \
              libmount1 libpcre3 libselinux1 libsepol2 libstdc++-10-dev libstdc++6 libuuid1 \
              ninja-build pkg-config rsync unzip xz-utils zlib1g unzip libsecret-1-dev libsecret-tools \
              libsecret-1-0 libjsoncpp-dev fuse flatpak-builder binutils coreutils desktop-file-utils \
              fakeroot fuse libgdk-pixbuf2.0-dev patchelf python3-pip python3-setuptools squashfs-tools \
              strace util-linux zsync"
ARG ANDROID_SDK_TOOLS_VERSION="8512546"
ARG ANDROID_SDK_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip"
ARG FLUTTER_VERSION="3.3.1"
ARG FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
ARG FREEDESKTOP_SDK_VERSION="22.08"

# Update packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y $PACKAGES

WORKDIR /opt

# Install Android SDK
ADD $ANDROID_SDK_TOOLS_URL .
RUN mkdir -p android-sdk/cmdline-tools && unzip commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip \
    && rm commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip && mv cmdline-tools android-sdk/cmdline-tools/latest

# Install Flutter
ADD $FLUTTER_URL .
RUN tar -vxf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
# Flutter doesn't work without write permissions, so fuck it, fuck.
RUN chmod -R 777 /opt/flutter
RUN git config --system --add safe.directory /opt/flutter

ENV ANDROID_HOME "/opt/android-sdk"
ENV ANDROID_SDK_ROOT "${ANDROID_HOME}"
ENV PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:/opt/flutter/bin"

# Install needed Android SDK packages
RUN yes | sdkmanager 'build-tools;30.0.3' 'platforms;android-29' 'platforms;android-30' 'platforms;android-31'

WORKDIR /tmp

# Prepare dependencies for offline build
RUN git clone --depth=1 --single-branch https://git.selfprivacy.org/kherel/selfprivacy.org.app.git deps
WORKDIR /tmp/deps
RUN flutter build linux
RUN flutter build apk
WORKDIR /tmp
RUN rm -rf deps

# Install Python dependencies
RUN pip3 install appimage-builder bandit setuptools portalocker pytz pytest pytest-mock \
                 pytest-datadir huey gevent mnemonic coverage pylint pydantic \
                 typing-extensions psutil black fastapi uvicorn strawberry-graphql \
                 python-multipart python-dateutil pygments poetry graphql-core

# Install Flatpak dependencies
RUN flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo \
    && flatpak install -y org.freedesktop.Sdk/x86_64/${FREEDESKTOP_SDK_VERSION} \
                          org.freedesktop.Platform/x86_64/${FREEDESKTOP_SDK_VERSION}
