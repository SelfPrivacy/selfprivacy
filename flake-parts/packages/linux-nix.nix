{
  sp,
  pkgs,
  lib,
  ...
}:

sp.ourFlutter.buildFlutterApplication {
  pname = sp.applicationMetadata.name;
  version = sp.applicationMetadata.version;

  src = sp.projectFiles;

  meta = {
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };

  autoPubspecLock = sp.flutterLockfile;

  desktopItem = pkgs.makeDesktopItem {
    name = "${sp.applicationMetadata.name}";
    exec = "@out@/bin/${sp.applicationMetadata.name}";
    desktopName = "SelfPrivacy";
  };

  postInstall = ''
    patchShebangs $out/bin/$pname
    chmod +x $out/bin/$pname
    wrapProgram $out/bin/$pname --set PATH ${lib.makeBinPath [ pkgs.xdg-user-dirs ]}

    mkdir -p $out/share/applications
    cp $desktopItem/share/applications/*.desktop $out/share/applications
    substituteInPlace $out/share/applications/*.desktop --subst-var out
  '';
}
