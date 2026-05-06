{ pkgs, ... }:

pkgs.appimageTools.wrapType2 {
  pname = "appimagetool";
  version = "1.9.1";

  src = pkgs.fetchurl {
    url = "https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage";
    hash = "sha256-7UzoTw2cr/ZvULzKb/bzWq5UzoE1QIs/ozq/w8s4TrA=";
  };
}
