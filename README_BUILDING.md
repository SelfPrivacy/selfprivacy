# SelfPrivacy Building and Running Guide

## Dependencies

### Runtime

#### AppImage

Tested on default Debian 10 with GNOME and Ubuntu 20.04 with GNOME, you need these runtime dependencies: `libgio libglib libgmodule libiconv libpcre libsecret`.

#### Debian/Ubuntu

```
sudo apt install libgtk-3 libglib2.0 libcairo2 libpango-1.0-0 libatk1.0-0 libgdk-pixbuf-2.0-0 libsecret-1-0 libepoxy0 libfontconfig1 zlib1g libc6 pcre2
```

#### Fedora

```
sudo dnf install -y gtk3 glib2 cairo pango atk gdk-pixbuf2 libsecret libepoxy fontconfig zlib glibc-common pcre2
```

#### Arch (Both Runtime and Buildtime)

```
sudo pacman -S --needed base-devel clang cmake ninja gtk3 glib2 cairo pango atk gdk-pixbuf2 libsecret libepoxy fontconfig zlib libiconv pcre2
```

### Buildtime

#### Debian/Ubuntu

```
sudo apt install build-essential clang cmake ninja-build pkg-config libgtk-3-dev libglib2.0-dev libcairo2-dev libpango1.0-dev libatk1.0-dev libgdk-pixbuf-2.0-dev libsecret-1-dev  libepoxy-dev libfontconfig1-dev zlib1g-dev
```

#### Fedora

```
sudo dnf groupinstall "Development Tools"
sudo dnf install clang cmake ninja-build pkgconf-pkg-config gtk3-devel glib2-devel cairo-devel pango-devel atk-devel gdk-pixbuf2-devel libsecret-devel libepoxy-devel fontconfig-devel zlib-devel
```

### Context

Inferring from this ldd output (2026-05-18, SelfPrivacy 0.13.4, Flutter 3.35.7):

```
linux-vdso.so.1
libdynamic_color_plugin.so
libflutter_secure_storage_linux_plugin.so
liburl_launcher_linux_plugin.so
libflutter_linux_gtk.so
libgtk-3.so.0
libgdk-3.so.0
libz.so.1
libpangocairo-1.0.so.0
libpango-1.0.so.0
libharfbuzz.so.0
libatk-1.0.so.0
libcairo-gobject.so.2
libcairo.so.2
libgdk_pixbuf-2.0.so.0
libgio-2.0.so.0
libgobject-2.0.so.0
libglib-2.0.so.0
libstdc++.so.6
libm.so.6
libgcc_s.so.1
libc.so.6
libgtk-3.so.0
libgdk-3.so.0
libz.so.1
libpangocairo-1.0.so.0
libpango-1.0.so.0
libharfbuzz.so.0
libatk-1.0.so.0
libcairo-gobject.so.2
libcairo.so.2
libgdk_pixbuf-2.0.so.0
libgio-2.0.so.0
libgobject-2.0.so.0
libglib-2.0.so.0
libstdc++.so.6
libgtk-3.so.0
libgdk-3.so.0
libz.so.1
libpangocairo-1.0.so.0
libpango-1.0.so.0
libharfbuzz.so.0
libatk-1.0.so.0
libcairo-gobject.so.2
libcairo.so.2
libgdk_pixbuf-2.0.so.0
libsecret-1.so.0
libgio-2.0.so.0
libgobject-2.0.so.0
libglib-2.0.so.0
libstdc++.so.6
libgtk-3.so.0
libgdk-3.so.0
libz.so.1
libpangocairo-1.0.so.0
libpango-1.0.so.0
libharfbuzz.so.0
libatk-1.0.so.0
libcairo-gobject.so.2
libcairo.so.2
libgdk_pixbuf-2.0.so.0
libgio-2.0.so.0
libgobject-2.0.so.0
libglib-2.0.so.0
libstdc++.so.6
libdl.so.2
libgtk-3.so.0
libgdk-3.so.0
libpangocairo-1.0.so.0
libpango-1.0.so.0
libatk-1.0.so.0
libcairo.so.2
libgio-2.0.so.0
libgobject-2.0.so.0
libglib-2.0.so.0
libepoxy.so.0
libfontconfig.so.1
libpthread.so.0
/lib64/ld-linux-x86-64.so.2
```

This Pixi/Conda configuration needed for building the project:

```
sysroot_linux-64
clangxx_linux-64
libstdcxx-devel_linux-64
cmake
git
curl
coreutils
ca-certificates
openssl
ninja
pkg-config
gtk3
libsecret
jsoncpp
freetype
harfbuzz
zlib
expat
glib
```

And our Nix dependencies:

```
gtk3
glib
pcre
util-linux
libselinux
libsepol
libthai
libdatrie
xorg.libXdmcp
xorg.libXtst
libxkbcommon
dbus
at-spi2-core
libsecret
jsoncpp
xorg.libX11
libepoxy
libgcrypt
libgpg-error
wayland
patchelf
wrapGAppsHook3
autoPatchelfHook
xdg-user-dirs
libsecret
```
