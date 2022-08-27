{ pkgs ? import <nixpkgs> { config.android_sdk.accept_license = true; } }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = "26.1.1";
    platformToolsVersion = "33.0.2";
    buildToolsVersions = [ "33.0.0" ];
  };
in
pkgs.mkShell {
  ANDROID_HOME= "${androidComposition.androidsdk}/libexec/android-sdk";
  ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
  nativeBuildInputs = with pkgs; [ flutter dart openjdk11 ];
}
