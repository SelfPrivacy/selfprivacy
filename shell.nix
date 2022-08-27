{ pkgs ? import <nixpkgs> { config.android_sdk.accept_license = true; } }:

let
  unstable = import (fetchTarball "https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz") {};

  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "26.1.1";
    platformToolsVersion = "33.0.2";
    buildToolsVersions = [ "33.0.0" ];
  };
in
pkgs.mkShell {
  ANDROID_HOME= "${androidComposition.androidsdk}/libexec/android-sdk";
  ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
  nativeBuildInputs = with pkgs; [ unstable.flutter openjdk11_headless ];
}
