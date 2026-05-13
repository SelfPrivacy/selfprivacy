{
  pkgs,
  lib,
  sp,
  ...
}:
let
  buildrootFS = pkgs.stdenvNoCC.mkDerivation {
    name = "${sp.applicationMetadata.name}-buildroot-fs";

    src = sp.buildrootDeps;
    nativeBuildInputs = with pkgs; [
      rpm
      cpio
    ];

    phases = [
      "buildPhase"
      "installPhase"
    ];

    buildPhase = ''
      mkdir -p $out

      rpm2cpio $src/*filesystem*.rpm | cpio -idmu -D $out
      chmod -R +w $out

      for rpm in $src/*.rpm; do
        [[ "$rpm" == "*filesystem*.rpm" ]] && continue
        rpm2cpio "$rpm" | cpio -idmu -D $out
        chmod -R +w $out
      done
    '';

    installPhase = ''
      mkdir -p $out/usr/bin

      for p in $($out/usr/sbin/busybox --list); do
        [[ "$p" == "sh" || "$p" == "bash" ]] && continue
        ln -snr $out/usr/sbin/busybox $out/usr/bin/$p
      done
    '';
  };
in
pkgs.stdenvNoCC.mkDerivation {
  name = "selfprivacy-buildroot";

  src = buildrootFS;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-rz83/ffahbThfABBe/akeyqDZYG4Ot7Szh2T4OoaQkg=";

  nativeBuildInputs = with pkgs; [
    bubblewrap
  ];

  phases = [ "buildPhase" ];

  buildPhase = ''
    mkdir -p $out rootfs

    cp -r $src/. rootfs/
    chmod -R +w rootfs

    cat > rootfs/etc/resolv.conf << EOL
    nameserver 1.1.1.1
    nameserver 8.8.8.8
    EOL

    mkdir -p rootfs/opt

    cp ${sp.buildrootPixi} rootfs/opt/pixi
    cp -r ${sp.buildrootPixiFiles}/. rootfs/opt/

    chmod -R +w rootfs/opt
    chmod +x rootfs/opt/pixi

    # bwrap --bind rootfs / --dev /dev --proc /proc --tmpfs /tmp --unshare-all --share-net \
    # --setenv PATH /usr/bin:/usr/sbin:/sbin:/bin --setenv TMPDIR /tmp --die-with-parent \
    # bash -c 'export HOME=$(mktemp -d) && export PIXI_CACHE_DIR=/opt/rattler/cache && \
    #          cd /opt && source <(/opt/pixi shell-hook) && /opt/flutter/bin/flutter --version && \
    #          rm -rf .pixi/envs/default/conda-meta && rm -rf $HOME'

    cp -r rootfs/. $out
  '';
}
