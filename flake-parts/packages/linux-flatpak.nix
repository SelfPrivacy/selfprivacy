{ pkgs, sp, ... }:

let
  libsecretGit = pkgs.fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "GNOME";
    repo = "libsecret";
    rev = "0.21.7";
    hash = "sha256-uN5+P2VkpoLqYVoruVj0/RM8rMNZSFu0VjKWW30bJrE=";
  };

  libjsoncppGit = pkgs.fetchFromGitHub {
    owner = "open-source-parsers";
    repo = "jsoncpp";
    rev = "1.9.7";
    hash = "sha256-rf8d2UNTVEZhuiyChK2XnUbfGDvsfXnKADhaSp8qBwQ=";
  };
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "${sp.applicationMetadata.name}-flatpak";
  version = sp.applicationMetadata.version;

  meta = {
    platforms = [ "x86_64-linux" ];
  };

  nativeBuildInputs = sp.flatpakTools;
  buildInputs = with pkgs; [ librsvg ];

  phases = [
    "buildPhase"
    "installPhase"
  ];

  buildPhase = ''
    export HOME="$NIX_BUILD_TOP"
    export FLATPAK_USER_DIR="$HOME/.local/share/flatpak"
    export FLATPAK_SYSTEM_DIR="$HOME/.local/share/flatpak"
    export XDG_DATA_HOME="$HOME/.local/share"
    mkdir -p $FLATPAK_USER_DIR

    mkdir vendor

    cp -r ${sp.applicationGeneric}/* vendor/
    cp -r ${libjsoncppGit} libjsoncpp
    cp -r ${libsecretGit} libsecret
    cp ${sp.flatpakManifestFile} flatpak-nix.yml
    cp ${sp.desktopFile} vendor/selfprivacy.desktop
    cp ${sp.appstreamFile} vendor/selfprivacy.metainfo.xml
    cp ${sp.iconPNGFile} vendor/selfprivacy.png
    cp ${sp.iconSVGFile} vendor/selfprivacy.svg

    chmod -R u+w vendor/ libsecret/ libjsoncpp/
  '';

  installPhase = ''
    mkdir -p $out

    mkdir -p $HOME/repo/{repo,objects,refs,extensions,state,tmp}
    ln -s ${sp.flatpakSDK}/config $HOME/repo/
    ln -s ${sp.flatpakSDK}/objects/* $HOME/repo/objects/
    ln -s ${sp.flatpakSDK}/refs/* $HOME/repo/refs/
    ostree --repo=$HOME/repo/ summary -u

    flatpak remote-add --user --if-not-exists --no-gpg-verify flathub $HOME/repo
    flatpak install --user -y flathub org.freedesktop.Sdk/${sp.shortSystem}/${sp.flatpakSDK.version} org.freedesktop.Platform/${sp.shortSystem}/${sp.flatpakSDK.version}
    flatpak-builder --user --force-clean --disable-cache --disable-rofiles-fuse --repo=flatpak-repo flatpak-build flatpak-nix.yml
    flatpak build-bundle flatpak-repo $out/${sp.applicationMetadata.name}-${sp.applicationMetadata.version}.flatpak org.selfprivacy.app
  '';
}
