{
  pkgs,
  lib,
  sp,
  ...
}:
let
  alma = "https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/Packages";
  epel = "https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages";

  fetch =
    repo: name: hash:
    pkgs.fetchurl {
      url = "${repo}/${name}";
      sha256 = hash;
    };

  pFilesystem = fetch alma "filesystem-3.8-6.el8.x86_64.rpm" "sha256-M+wZm374VldwQn5OrTRedbXY6W/74z8CNa4IjuRyY2E=";
  pGlibc = fetch alma "glibc-2.28-251.el8_10.34.x86_64.rpm" "sha256-IWeHdVV1xkurDHd7mZQYU+ldIvYtPalOpobeFgZ6LYs=";
  pGlibcCommon = fetch alma "glibc-common-2.28-251.el8_10.34.x86_64.rpm" "sha256-w2vorcxiIdbynMZgIY6cfrmE1UwJeqIu0VlNfrT7ASA=";
  pNcursesLibs = fetch alma "ncurses-libs-6.1-10.20180224.el8.x86_64.rpm" "sha256-CSg3LEsDJ8RUzk35cKXq4aXbZn7TYJAlE7LpNmpEIpI=";
  pBash = fetch alma "bash-4.4.20-6.el8_10.x86_64.rpm" "sha256-YJtRT9nLEyFQWGHdNOcOGWe4U5JE/uETDgqFov6fV2g=";
  pBusybox = fetch "${epel}/b" "busybox-1.35.0-3.el8.x86_64.rpm" "sha256-CK9dZS/BWpTnnrVVUKVXGxH9ugbO/v8kepI96ON/ytw=";

  buildrootFS = pkgs.stdenvNoCC.mkDerivation {
    name = "${sp.applicationMetadata.name}-buildroot-fs";

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

      for p in "${pFilesystem}" "${pGlibc}" "${pGlibcCommon}" "${pNcursesLibs}" "${pBash}" "${pBusybox}"; do
        rpm2cpio "$p" | cpio -idmu -D $out
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

    cp -r rootfs/. $out
  '';
}
