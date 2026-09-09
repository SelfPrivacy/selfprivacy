{ sp, ... }:

sp.ourFlutter.buildFlutterApplication {
  pname = "widgetbook";
  version = sp.applicationMetadata.version;
  src = sp.projectFiles;

  autoPubspecLock = sp.flutterLockfile;
  gitHashes = sp.flutterGitHashes;
  flutterBuildFlags = [ "--target=tool/widgetbook/main.dart" ];

  postInstall = ''
    mv $out/bin/${sp.applicationMetadata.name} $out/bin/widgetbook
  '';

  meta = {
    mainProgram = "widgetbook";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
