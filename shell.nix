with (import <nixpkgs> { });

mkShell {
  buildInputs = [
    at-spi2-core.dev
    clang
    cmake
    dart
    dbus.dev
    flutter
    gtk3
    libdatrie
    libepoxy.dev
    libselinux
    libsepol
    libthai
    libxkbcommon
    libsecret
    ninja
    pcre
    pkg-config
    util-linux.dev
    xorg.libXdmcp
    xorg.libXtst
    xorg.libX11

    glib
    jsoncpp
    libgcrypt
    libgpg-error
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${libepoxy}/lib
  '';
}
