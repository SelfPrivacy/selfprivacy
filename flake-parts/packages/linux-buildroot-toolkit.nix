{ pkgs, sp, lib, ... }:
pkgs.stdenvNoCC.mkDerivation {
  name = "selfprivacy-buildroot-toolkit";

  src = sp.buildrootPixiFiles;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "sha256-Vbs6rYgyDzW+G5fIompPVMGOsPiPPphXiptVcdf579Q=";

  phases = [ "installPhase" ];

  installPhase = ''
    export HOME=$(mktemp -d)

    mkdir -p $out

    cp -r $src/. .
    cp ${sp.buildrootPixi} ./pixi
    chmod +x ./pixi

    CONDA_OVERRIDE_GLIBC=2.28 ./pixi install --frozen
    rm -rf .pixi/envs/default/conda-meta

    cp -r .pixi $out/
    cp -r $HOME/.cache/rattler $out/

    ln -sr $out/.pixi/envs/default/bin/clang-22 $out/.pixi/envs/default/bin/clang
    ln -sr $out/.pixi/envs/default/bin/clang++-22 $out/.pixi/envs/default/bin/clang++
  '';
}
