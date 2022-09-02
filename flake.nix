{
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs-unstable }:
    let
      pkgs = import nixpkgs-unstable { config.allowUnfree = true; config.android_sdk.accept_license = true; };
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        toolsVersion = "26.1.1";
        platformToolsVersion = "33.0.2";
        buildToolsVersions = [ "30.0.3" ];
        platformVersions = [ "31" "30" "29" ];
      };
    in {
      devShell.x86_64-linux = pkgs.mkShell {
        JAVA_HOME = "${pkgs.openjdk11_headless.home}";
        ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
        ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";

        buildInputs = with pkgs; [ bash git androidComposition.androidsdk flutter openjdk11_headless ];
      };
    };
}
