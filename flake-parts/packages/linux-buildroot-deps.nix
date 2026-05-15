{
  pkgs,
  sp,
  lib,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "selfprivacy-buildroot-deps";

  nativeBuildInputs = [ sp.buildrootPixiPack ];

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-jwBzEqdCKdMJD+v3o4cndN7Op4GF3xEvgV1Rr9RiLM4=";

  phases = [ "buildPhase" ];

  buildPhase = ''
    mkdir -p $out

    cp ${sp.buildrootPixiFiles}/* .

    pixi-pack --output-file $out/deps.tar
  '';
}
