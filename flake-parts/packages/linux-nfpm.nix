{
  pkgs,
  sp,
  nfpmType,
  ...
}:

pkgs.stdenvNoCC.mkDerivation rec {
  name = "${sp.applicationMetadata.name}-${nfpmType}";
  version = sp.applicationMetadata.version;

  src = sp.projectFiles;

  meta = {
    platforms = [ "x86_64-linux" ];
  };

  nativeBuildInputs = with pkgs; [ nfpm lndir ];

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    shopt -s extglob

    mkdir -p builddir/assets/images/icon
    cp $src/selfprivacy* $src/nfpm.yaml builddir/
    cp $src/assets/images/icon/logo.svg builddir/assets/images/icon/

    pushd builddir

    mkdir linux-portable

    cp -r ${sp.applicationPortable}/* linux-portable/
    chmod -R a+w linux-portable/
    rm linux-portable/lib/!(libapp.so|libdynamic*.so|libflutter*.so|liburl*.so)

    export VERSION="${version}"
    nfpm pkg --packager ${nfpmType}

    popd
  '';

  installPhase = ''
    mkdir -p $out

    if [[ "${nfpmType}" == "archlinux" ]]; then
      cp -r builddir/*.tar.zst $out/
    else
      cp -r builddir/*.${nfpmType} $out/
    fi
  '';
}
