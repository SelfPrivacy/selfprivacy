#!/bin/sh

export PATH="$PATH:$CONDA_PREFIX/libexec/git-core"
export PKG_CONFIG_PATH="$CONDA_PREFIX/lib/pkgconfig"

if [[ ! -f "$CONDA_PREFIX/bin/clang" ]]; then ln -sr "$CONDA_PREFIX/bin/clang22" "$CONDA_PREFIX/bin/clang"; fi
if [[ ! -f "$CONDA_PREFIX/bin/clang++" ]]; then ln -sr "$CONDA_PREFIX/bin/clang++-22" "$CONDA_PREFIX/bin/clang++"; fi

git config --global http.sslCAInfo "$CONDA_PREFIX/ssl/cacert.pem"
