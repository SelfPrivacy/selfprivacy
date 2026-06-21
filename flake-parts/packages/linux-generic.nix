{ pkgs, sp, ... }:

pkgs.stdenvNoCC.mkDerivation {
  name = "${sp.applicationMetadata.name}-generic";
  version = sp.applicationMetadata.version;

  meta = {
    platforms = [ "x86_64-linux" ];
    mainProgram = "selfprivacy";
  };

  nativeBuildInputs = with pkgs; [ patchelf ];

  phases = [
    "installPhase"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ${sp.applicationNix}/app/selfprivacy/* $out/
    chmod -R u+w $out/

    patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../lib:$ORIGIN/../usr/lib:/usr/lib/x86_64-linux-gnu:/app/lib' $out/selfprivacy
    patchelf --set-interpreter '/lib64/ld-linux-x86-64.so.2' $out/selfprivacy
    for plib in "libdynamic_color_plugin.so" "libflutter_linux_gtk.so" "libflutter_secure_storage_linux_plugin.so" "liburl_launcher_linux_plugin.so"; do
      patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../lib:$ORIGIN/../usr/lib:/usr/lib/x86_64-linux-gnu:/app/lib' $out/lib/"$plib"
    done

    ln -sr $out/selfprivacy $out/bin/selfprivacy
  '';
}
