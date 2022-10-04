import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';

enum LoadingStatus {
  uninitialized,
  refreshing,
  success,
  error,
}

enum InitializingSteps {
  setHetznerKey,
  setCloudFlareKey,
  setDomainName,
  setRootUser,
  createServer,
  checkCloudFlareDns,
  startServer,
  checkSystemDnsAndDkimSet,
}

enum Period {
  hour,
  day,
  month;

  int get stepPeriodInSeconds {
    switch (this) {
      case Period.hour:
        return 18;
      case Period.day:
        return 432;
      case Period.month:
        return 6480;
    }
  }
}

enum ServiceTypes {
  mailserver,
  bitwarden,
  jitsi,
  nextcloud,
  pleroma,
  gitea,
  ocserv,
}

extension ServiceTypesExt on ServiceTypes {
  String get title {
    switch (this) {
      case ServiceTypes.mailserver:
        return 'mail.title'.tr();
      case ServiceTypes.bitwarden:
        return 'password_manager.title'.tr();
      case ServiceTypes.jitsi:
        return 'video.title'.tr();
      case ServiceTypes.nextcloud:
        return 'cloud.title'.tr();
      case ServiceTypes.pleroma:
        return 'social_network.title'.tr();
      case ServiceTypes.gitea:
        return 'git.title'.tr();
      case ServiceTypes.ocserv:
        return 'vpn.title'.tr();
    }
  }

  String get subtitle {
    switch (this) {
      case ServiceTypes.mailserver:
        return 'mail.subtitle'.tr();
      case ServiceTypes.bitwarden:
        return 'password_manager.subtitle'.tr();
      case ServiceTypes.jitsi:
        return 'video.subtitle'.tr();
      case ServiceTypes.nextcloud:
        return 'cloud.subtitle'.tr();
      case ServiceTypes.pleroma:
        return 'social_network.subtitle'.tr();
      case ServiceTypes.gitea:
        return 'git.subtitle'.tr();
      case ServiceTypes.ocserv:
        return 'vpn.subtitle'.tr();
    }
  }

  String get loginInfo {
    switch (this) {
      case ServiceTypes.mailserver:
        return 'mail.login_info'.tr();
      case ServiceTypes.bitwarden:
        return 'password_manager.login_info'.tr();
      case ServiceTypes.jitsi:
        return 'video.login_info'.tr();
      case ServiceTypes.nextcloud:
        return 'cloud.login_info'.tr();
      case ServiceTypes.pleroma:
        return 'social_network.login_info'.tr();
      case ServiceTypes.gitea:
        return 'git.login_info'.tr();
      case ServiceTypes.ocserv:
        return '';
    }
  }

  String get subdomain {
    switch (this) {
      case ServiceTypes.bitwarden:
        return 'password';
      case ServiceTypes.jitsi:
        return 'meet';
      case ServiceTypes.nextcloud:
        return 'cloud';
      case ServiceTypes.pleroma:
        return 'social';
      case ServiceTypes.gitea:
        return 'git';
      case ServiceTypes.ocserv:
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case ServiceTypes.mailserver:
        return BrandIcons.envelope;
      case ServiceTypes.bitwarden:
        return BrandIcons.key;
      case ServiceTypes.jitsi:
        return BrandIcons.webcam;
      case ServiceTypes.nextcloud:
        return BrandIcons.upload;
      case ServiceTypes.pleroma:
        return BrandIcons.social;
      case ServiceTypes.gitea:
        return BrandIcons.git;
      case ServiceTypes.ocserv:
        return Icons.vpn_lock_outlined;
    }
  }

  String get txt => toString().split('.')[1];
}
