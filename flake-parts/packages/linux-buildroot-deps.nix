{
  pkgs,
  lib,
  ...
}:
let
  buildrootPackages =
    let
      alma = "https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/Packages";
      epel = "https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages";

      fetch =
        repo: name: hash:
        pkgs.fetchurl {
          url = "${repo}/${name}";
          sha256 = hash;
        };
    in
    [
      (fetch alma "basesystem-11-5.el8.noarch.rpm" "sha256-dorcsbA0kfjI4cKDV3EwtR9aPWIV62ZnYF2JliGbhaA=")
      (fetch alma "bash-4.4.20-6.el8_10.x86_64.rpm" "sha256-YJtRT9nLEyFQWGHdNOcOGWe4U5JE/uETDgqFov6fV2g=")
      (fetch alma "filesystem-3.8-6.el8.x86_64.rpm" "sha256-M+wZm374VldwQn5OrTRedbXY6W/74z8CNa4IjuRyY2E=")
      (fetch alma "glibc-2.28-251.el8_10.34.x86_64.rpm"
        "sha256-IWeHdVV1xkurDHd7mZQYU+ldIvYtPalOpobeFgZ6LYs="
      )
      # (fetch alma "curl-7.61.1-34.el8_10.10.x86_64.rpm"
      #   "sha256-8jCKH36cR0X6j5R8KrABbJmTMKmqat1z/CvEm01ltKE="
      # )
      # (fetch alma "libcurl-7.61.1-34.el8.x86_64.rpm"
      #   "sha256-Th3E1g3lhS2/bne3r2KOkqjY7inRYRzF7KeLajU6W+A="
      # )
      # (fetch alma "libidn2-2.2.0-1.el8.x86_64.rpm" "sha256-1PESy1eC7LxIc83EJWuty83u+Ukos8eTDJ5LEBNL1KY=")
      # (fetch alma "libunistring-0.9.9-3.el8.x86_64.rpm" "sha256-DR1Jf+Kw61TIgJPCrKkikvtOlObhQ3rzve+7D1resGs=")
      (fetch alma "zlib-1.2.11-25.el8.x86_64.rpm" "sha256-q0DoXxgKbTjOApFAi371xCIlD1PLJsRDme8aToYid44=")
      (fetch alma "libgcc-8.5.0-28.el8_10.alma.1.x86_64.rpm"
        "sha256-YpoIJm98E5fADXwywKxtEQ/lbpk9z5QCRVmqKKVw8Y0="
      )
      (fetch alma "libstdc++-8.5.0-28.el8_10.alma.1.x86_64.rpm"
        "sha256-AwK5AG1xmjHdUa6vMf7APXCq1cMYZ0U3vYDEn5F0sGY="
      )
      # (fetch alma "ca-certificates-2025.2.80_v9.0.304-80.2.el8_10.noarch.rpm"
      #   "sha256-UX4ArSBdQvLB8qqOmrVAJIBeHPNILGqIIci5L6UZjMk="
      # )
      # (fetch alma "openssl-1.1.1k-15.el8_6.x86_64.rpm"
      #   "sha256-3IoLKGc5grcceBpOBHzCPRxstN771noU5tEhCFN25gA="
      # )
      (fetch alma "glibc-common-2.28-251.el8_10.34.x86_64.rpm"
        "sha256-w2vorcxiIdbynMZgIY6cfrmE1UwJeqIu0VlNfrT7ASA="
      )
      (fetch alma "libselinux-2.9-11.el8_10.x86_64.rpm"
        "sha256-fM+PfpUO4o2YQzcNPiN5DLzWyoZ4CjnzO/v9nRL6xLo="
      )
      (fetch alma "glibc-gconv-extra-2.28-251.el8_10.34.x86_64.rpm"
        "sha256-ESN/MGu+7wXfcJvvbtjB5zknTwTGKxJoCBGhhJTqnJ4="
      )
      (fetch alma "libsepol-2.9-3.el8.x86_64.rpm" "sha256-Vb+/VX5mhlez2Om3OJyeyJlEycIZV+7LXjEanVCncI0=")
      (fetch alma "ncurses-base-6.1-10.20180224.el8.noarch.rpm"
        "sha256-VrMPuXIYnIsKBSJhYkLUGuhyQUwH0zQBUQNApe+CYRQ="
      )
      (fetch alma "ncurses-libs-6.1-10.20180224.el8.x86_64.rpm"
        "sha256-CSg3LEsDJ8RUzk35cKXq4aXbZn7TYJAlE7LpNmpEIpI="
      )
      (fetch alma "pcre2-10.32-3.el8_6.x86_64.rpm" "sha256-Q07tJFj1oATvbbiGr+ec1SQcEsxN5ALe1N1Ro8mO0mI=")
      (fetch alma "setup-2.12.2-9.el8.noarch.rpm" "sha256-bNPxaX6f3E4Ui1SjtTgDzkLmZofT4L6mb9e970BlwcY=")
      (fetch alma "tzdata-2026a-1.el8.noarch.rpm" "sha256-wuElxpbQjCy6b8jFoT+8W5gT3uAB14+UxOQh66puPSg=")
      (fetch alma "glibc-all-langpacks-2.28-251.el8_10.34.x86_64.rpm"
        "sha256-17ROOQl5XUv5ynZkhXQRpwqVaR+rnPSaZgFGf/IM8KY="
      )
      (fetch alma "almalinux-release-8.10-1.el8.x86_64.rpm" "sha256-nOPOJyo336v6N9iqTaiXvW3AH3bvNHYJY9RN04R6+iw=")
      (fetch "${epel}/b" "busybox-1.35.0-3.el8.x86_64.rpm"
        "sha256-CK9dZS/BWpTnnrVVUKVXGxH9ugbO/v8kepI96ON/ytw="
      )
    ];
in
pkgs.stdenvNoCC.mkDerivation {
  name = "selfprivacy-buildroot-deps";

  srcs = buildrootPackages;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out

    for src in $srcs; do
      ln -s $src $out/
    done
  '';
}
