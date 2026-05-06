{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "appimage-runtime";
  version = "20251108";

  src = pkgs.fetchurl {
    url = "https://github.com/AppImage/type2-runtime/releases/download/continuous/runtime-x86_64";
    hash = "sha256-okGdzkdWg5WuecAf+ppaNB3TOVgTUv8QTQc1J1Qxd+U=";
  };

  phases = [
    "installPhase"
    "patchPhase"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
  '';
}
